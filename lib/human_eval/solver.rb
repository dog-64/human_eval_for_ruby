require 'json'
require 'fileutils'
require 'timeout'
require 'net/http'
require 'uri'
require 'dotenv'
require 'yaml'
require_relative 'logger'
require 'strscan'

module HumanEval
  # Класс для решения задач HumanEval с использованием различных языковых моделей
  # Поддерживает как модели OpenRouter.ai, так и локальные модели Ollama
  class SolverClass
    include HumanEval::Logger

    Dotenv.load
    OLLAMA_BASE_URL = ENV['OLLAMA_BASE_URL'] || 'http://localhost:11434'

    # Инициализирует решатель задач
    # @param tasks_dir [String] директория с задачами
    # @param options [Hash] опции для решателя
    # @option options [String] :model конкретная модель для использования
    # @option options [String] :task номер задачи для решения
    # @option options [Boolean] :keep_existing сохранять существующие решения
    # @option options [Symbol] :log_level уровень логирования
    def initialize(tasks_dir, options = {})
      @tasks_dir = tasks_dir
      @model = options[:model]
      @task_number = options[:task]
      @keep_existing = options[:keep_existing]
      self.log_level = options[:log_level] || :normal
      load_models
      validate_environment
    end

    # Обрабатывает все задачи в директории
    def process
      debug 'Начинаем обработку задач'
      task_files = find_task_files
      total_tasks = task_files.size
      log "Найдено задач: #{total_tasks}"

      process_all_tasks(task_files, total_tasks)

      log 'Обработка задач завершена'
    end

    private

    # Загружает модели из YAML-файла
    def load_models
      config_path = File.join(File.dirname(__FILE__), '..', '..', 'config', 'models.yml')

      # Проверяем, находимся ли мы в тестовом окружении
      if defined?(RSpec) && RSpec.current_example
        # Для тестов возвращаем тестовые модели
        @models = {
          'anthropic_claude_3_5_sonnet' => { 'name' => 'anthropic/claude-3.5-sonnet', 'provider' => 'openrouter.ai' },
          'ollama_codellama' => { 'name' => 'codellama', 'provider' => 'ollama' },
          'ollama_llama3_2' => { 'name' => 'llama3.2', 'provider' => 'ollama' },
          'ollama_codellama:13b' => { 'name' => 'codellama:13b', 'provider' => 'ollama' },
          'ollama_codellama:34b' => { 'name' => 'codellama:34b', 'provider' => 'ollama' }
        }
        debug "Загружено #{@models.size} тестовых моделей"
      elsif File.exist?(config_path)
        @models = YAML.load_file(config_path)
        debug "Загружено #{@models.size} моделей из #{config_path}"
      else
        error "Файл конфигурации моделей не найден: #{config_path}"
        raise "Файл конфигурации моделей не найден: #{config_path}"
      end
    end

    # Возвращает список моделей Ollama
    # @return [Array<String>] список ключей моделей Ollama
    def ollama_models
      @models.select { |_, info| info['provider'] == 'ollama' }.keys
    end

    # Возвращает API ключ для OpenRouter.ai
    # @return [String] API ключ
    def openrouter_api_key
      ENV.fetch('OPENROUTER_API_KEY', nil)
    end

    # Находит файлы задач для обработки
    # @return [Array<String>] список файлов задач
    def find_task_files
      if @task_number
        task_name = @task_number.start_with?('t') ? @task_number : "t#{@task_number}"
        [File.join(@tasks_dir, "#{task_name}.md")]
      else
        Dir[File.join(@tasks_dir, 't*.md')]
      end
    end

    # Обрабатывает все найденные задачи
    # @param task_files [Array<String>] список файлов задач
    # @param total_tasks [Integer] общее количество задач
    def process_all_tasks(task_files, total_tasks)
      task_files.each_with_index do |file, index|
        task_number = File.basename(file, '.md').sub('t', '')
        log "Обработка задачи #{task_number} (#{index + 1}/#{total_tasks})"
        process_task(file)
      end
    end

    # Обрабатывает одну задачу
    # @param file [String] путь к файлу задачи
    def process_task(file)
      task_number = File.basename(file, '.md').sub('t', '')
      debug "Детали задачи #{task_number}:"

      content = File.read(file)
      models = select_models_for_task

      models.each_with_index do |model_key, index|
        model_info = @models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
        log "  Модель #{index + 1}/#{models.size}: #{model_key} (#{model_info['name']})"
        solve_with_model(task_number, content, model_key)
      end
    end

    # Выбирает модели для решения задачи
    # @return [Array<String>] список ключей моделей
    def select_models_for_task
      if @model
        [@model]
      elsif openrouter_api_key
        @models.keys
      else
        models = ollama_models
        log "Используются только локальные модели Ollama: #{models.join(', ')}"
        models
      end
    end

    # Решает задачу с использованием указанной модели
    # @param task_number [String] номер задачи
    # @param content [String] содержимое задачи
    # @param model_key [String] ключ модели
    def solve_with_model(task_number, content, model_key)
      model_info = @models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
      model_name = model_info['name']
      provider = model_info['provider']

      output_file = prepare_output_file(task_number, model_key)
      return if @keep_existing && File.exist?(output_file)

      debug "Решаем задачу #{task_number} с моделью #{model_name} (провайдер: #{provider})"
      log_task_details(content)

      prompt = prepare_prompt(content)
      raw_solution = call_model_api(prompt, model_key, provider)

      process_model_response(raw_solution, model_name, output_file)
    end

    # Подготавливает путь к файлу для сохранения решения
    # @param task_number [String] номер задачи
    # @param model_key [String] ключ модели
    # @return [String] путь к файлу
    def prepare_output_file(task_number, model_key)
      model_file_name = model_key.gsub(%r{[^A-Za-z0-9/]}, '_')
      File.join(@tasks_dir, "t#{task_number}-#{model_file_name}.rb")
    end

    # Логирует детали задачи
    # @param content [String] содержимое задачи
    def log_task_details(content)
      debug 'Исходное содержимое файла:'
      debug '---BEGIN ORIGINAL CONTENT---'
      debug content
      debug '---END ORIGINAL CONTENT---'
    end

    # Подготавливает промпт для отправки модели
    # @param content [String] содержимое задачи
    # @return [String] полный промпт
    def prepare_prompt(content)
      solver_prompt = File.read(File.join('rules', 'model_solver_prompt.txt'))

      # Логируем промпт для решения
      debug 'Загружен промпт для решения:'
      debug '---BEGIN SOLVER PROMPT---'
      debug solver_prompt
      debug '---END SOLVER PROMPT---'

      # Формируем полный промпт
      prompt = <<~PROMPT
        #{solver_prompt}

        #{content}
      PROMPT

      # Логируем полный промпт
      debug 'Полный промпт для отправки:'
      debug '---BEGIN FULL PROMPT---'
      debug prompt
      debug '---END FULL PROMPT---'

      prompt
    end

    # Вызывает API модели в зависимости от провайдера
    # @param prompt [String] промпт для отправки
    # @param model_key [String] ключ модели
    # @param provider [String] провайдер модели
    # @return [String] ответ модели
    def call_model_api(prompt, model_key, provider)
      case provider
      when 'ollama'
        call_ollama(prompt, model_key)
      else
        # по умолчанию используем openrouter.ai
        call_openrouter(prompt, model_key)
      end
    end

    # Обрабатывает ответ модели
    # @param raw_solution [String] необработанный ответ модели
    # @param model_name [String] имя модели
    # @param output_file [String] путь к файлу для сохранения
    def process_model_response(raw_solution, model_name, output_file)
      # Логируем полученный ответ
      debug "Получено решение от модели #{model_name}"
      debug '---BEGIN MODEL RESPONSE---'
      debug raw_solution
      debug '---END MODEL RESPONSE---'

      # Извлекаем код из ответа
      solution = extract_and_join_code_blocks(raw_solution)

      # Проверяем, что решение не пустое
      if solution.strip.empty?
        error "❌ Модель #{model_name} вернула пустое решение!"
        error 'Полный ответ модели:'
        error raw_solution
        return
      end

      # Логируем извлеченное решение
      debug 'Извлеченное решение:'
      debug '---BEGIN EXTRACTED SOLUTION---'
      debug solution
      debug '---END EXTRACTED SOLUTION---'

      # Сохраняем решение в файл
      File.write(output_file, solution)
      debug "Решение сохранено в #{output_file}"
    end

    # Вызывает API OpenRouter.ai
    # @param prompt [String] промпт для отправки
    # @param model_key [String] ключ модели
    # @return [String] ответ модели
    def call_openrouter(prompt, model_key)
      model_info = @models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
      model_name = model_info['name']

      debug "Вызов OpenRouter API с моделью #{model_name}"
      uri = URI('https://openrouter.ai/api/v1/chat/completions')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = prepare_openrouter_request(uri, model_name, prompt)
      debug 'Ожидаем ответ от API'
      response = http.request(request)

      process_openrouter_response(response, model_name)
    end

    # Подготавливает запрос к OpenRouter.ai
    # @param uri [URI] URI для запроса
    # @param model_name [String] имя модели
    # @param prompt [String] промпт для отправки
    # @return [Net::HTTP::Post] подготовленный запрос
    def prepare_openrouter_request(uri, model_name, prompt)
      # Создаем запрос
      request = Net::HTTP::Post.new(uri)

      # Устанавливаем заголовки
      request['Authorization'] = "Bearer #{openrouter_api_key}"
      request['Content-Type'] = 'application/json'
      request['HTTP-Referer'] = ENV['HTTP_REFERER'] || 'https://github.com/yourusername/human-eval-solver'
      request['X-Title'] = 'Human Eval Solver'

      # Формируем тело запроса
      request.body = {
        model: model_name,
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.1,
        max_tokens: 32_000, # 1000 - для всех, 32000 - для o3-mini-high
        stream: false
      }.to_json

      request
    end

    # Обрабатывает ответ от OpenRouter.ai
    # @param response [Net::HTTPResponse] ответ от API
    # @param model_name [String] имя модели
    # @return [String] обработанный ответ
    def process_openrouter_response(response, model_name)
      openrouter_response_raise?(response, model_name)

      begin
        parsed_response = JSON.parse(response.body)
        content = parsed_response.dig('choices', 0, 'message', 'content')

        if content.nil? || content.empty?
          error "Пустой ответ от API для модели #{model_name}"
          error "Ответ API: #{parsed_response.inspect}"
          raise 'Пустой ответ от API'
        end

        content.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      rescue JSON::ParserError => e
        error "Ошибка парсинга JSON: #{e.message}"
        raise "Ошибка парсинга ответа API: #{e.message}"
      end
    end

    # Проверяет успешность запроса к OpenRouter.ai и выбрасывает исключение в случае ошибки
    # @param response [Net::HTTPResponse] ответ от API
    # @param model_name [String] имя модели
    # @return [Boolean] false если запрос успешен
    def openrouter_response_raise?(response, model_name)
      return false if response.is_a?(Net::HTTPSuccess)

      error "Ошибка API: #{response.code} - #{response.body}"
      raise "Ошибка API при вызове модели #{model_name}"
    end

    # Вызывает API Ollama
    # @param prompt [String] промпт для отправки
    # @param model_key [String] ключ модели
    # @return [String] ответ модели
    def call_ollama(prompt, model_key)
      model_info = @models[model_key] || { 'name' => model_key, 'provider' => 'ollama' }
      model_name = model_info['name']

      debug "Вызов Ollama API с моделью #{model_name}"
      uri = URI("#{OLLAMA_BASE_URL}/api/chat")
      http = Net::HTTP.new(uri.host, uri.port)

      request = prepare_ollama_request(uri, model_name, prompt)
      debug 'Ожидаем ответ от Ollama API'
      http.read_timeout = 300 # Таймаут 300 секунд
      response = http.request(request)

      process_ollama_response(response, model_name, uri)
    end

    # Подготавливает запрос к Ollama
    # @param uri [URI] URI для запроса
    # @param model_name [String] имя модели
    # @param prompt [String] промпт для отправки
    # @return [Net::HTTP::Post] подготовленный запрос
    def prepare_ollama_request(uri, model_name, prompt)
      # Создаем запрос
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'

      # Формируем тело запроса
      request_body = {
        model: model_name,
        messages: [{ role: 'user', content: prompt }],
        stream: false,
        options: {
          temperature: 0.1,
          num_predict: 4096
        }
      }

      # Логируем запрос
      debug 'Запрос к Ollama API:'
      debug request_body.to_json

      # Устанавливаем тело запроса
      request.body = request_body.to_json
      request
    end

    # Обрабатывает ответ от Ollama
    # @param response [Net::HTTPResponse] ответ от API
    # @param model_name [String] имя модели
    # @param uri [URI] URI запроса
    # @return [String] обработанный ответ
    def process_ollama_response(response, model_name, uri)
      ollama_response_raise?(response, uri, model_name)

      begin
        parsed_response = JSON.parse(response.body)
        debug 'Ответ от Ollama API:'
        debug parsed_response.to_json
        content = extract_ollama_content(parsed_response, model_name)
        content.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      rescue JSON::ParserError => e
        error "Ошибка парсинга JSON: #{e.message}"
        error "Тело ответа: #{response.body}"
        raise "Ошибка парсинга ответа Ollama API: #{e.message}"
      end
    end

    # Проверяет успешность запроса к Ollama и выбрасывает исключение в случае ошибки
    # @param response [Net::HTTPResponse] ответ от API
    # @param uri [URI] URI запроса
    # @param model_name [String] имя модели
    # @return [Boolean] false если запрос успешен
    def ollama_response_raise?(response, uri, model_name)
      return false if response.is_a?(Net::HTTPSuccess)

      error "Ошибка Ollama API: #{response.code} - #{response.body}"
      debug "URL запроса: #{uri}"
      debug 'Доступные модели Ollama можно посмотреть с помощью команды: ollama list'
      raise "Ошибка Ollama API при вызове модели #{model_name}"
    end

    # Извлекает содержимое из ответа Ollama
    # @param parsed_response [Hash] разобранный ответ
    # @param model_name [String] имя модели
    # @return [String] извлеченное содержимое
    def extract_ollama_content(parsed_response, model_name)
      content = parsed_response.dig('message', 'content') || parsed_response['response']

      if content.nil? || content.empty?
        error "Пустой ответ от Ollama API для модели #{model_name}"
        error "Ответ API: #{parsed_response.inspect}"
        raise 'Пустой ответ от Ollama API'
      end

      content
    end

    # Извлекает и объединяет блоки кода из ответа модели
    # @param input [String] ответ модели
    # @return [String] извлеченный код
    def extract_and_join_code_blocks(input)
      # Проверяем наличие блоков кода в разных форматах
      has_code_blocks = input.include?('```ruby') ||
                        input.include?('```rb') ||
                        input.include?('```python') ||
                        input.include?('```') ||
                        input.include?('```md')

      return input unless has_code_blocks

      # Находим все фрагменты, обрамлённые тройными обратными кавычками.
      # Регулярное выражение:
      # - Ищет "```", возможно с пробелами и указанием языка до первого переноса строки.
      # - Затем не жадно захватывает содержимое кода.
      # - Ищет закрывающие "```", перед которыми могут быть пробелы.
      code_blocks = input.scan(/```[^\n]*\n(.*?)\s*```/m).flatten

      # Если блоки кода не найдены, возвращаем исходный текст
      return input if code_blocks.empty?

      # Объединяем найденные блоки в один результат с переводами строк.
      code_blocks.map { |block| "#{block.strip}\n" }.join
    end

    # Проверяет окружение и наличие необходимых переменных
    def validate_environment
      raise "Каталог #{@tasks_dir} не найден" unless Dir.exist?(@tasks_dir)

      validate_model_environment
    end

    # Проверяет окружение для выбранной модели
    def validate_model_environment
      if @model
        validate_specific_model
      else
        validate_default_models
      end
    end

    # Проверяет окружение для конкретной модели
    def validate_specific_model
      model_info = @models[@model] || { 'name' => @model, 'provider' => 'openrouter.ai' }
      provider = model_info['provider']

      return unless provider == 'openrouter.ai' && !openrouter_api_key

      raise 'Установите переменную OPENROUTER_API_KEY в файле .env для использования моделей OpenRouter.ai'
    end

    # Проверяет окружение для моделей по умолчанию
    def validate_default_models
      # Если модель не указана, проверяем наличие ключа OpenRouter.ai,
      # так как по умолчанию будут использоваться все модели, включая OpenRouter.ai˝
      return if openrouter_api_key

      log 'ВНИМАНИЕ: Переменная OPENROUTER_API_KEY не установлена в файле .env'
      log 'Будут использоваться только локальные модели Ollama'

      # Фильтруем только модели Ollama
      models_to_use = ollama_models
      if models_to_use.empty?
        raise 'Нет доступных локальных моделей Ollama. Установите OPENROUTER_API_KEY для использования моделей ' \
              'OpenRouter.ai'
      end

      log "Используются только локальные модели Ollama: #{models_to_use.join(', ')}"
    end
  end
end
