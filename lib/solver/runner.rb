require 'json'
require 'fileutils'
require 'timeout'
require 'net/http'
require 'uri'
require 'dotenv'
require 'yaml'
require_relative '../logger'
require_relative '../models'
require_relative '../model/to_path'
require 'strscan'

module Solver
  # Класс для решения задач HumanEval с использованием различных языковых моделей
  # Поддерживает как модели OpenRouter.ai, так и локальные модели Ollama
  class Runner
    include Logger

    Dotenv.load
    OLLAMA_BASE_URL = ENV['OLLAMA_BASE_URL'] || 'http://localhost:11434'

    # Инициализирует решатель задач
    # @param tasks_dir [String] директория с задачами
    # @param options [Hash] опции для решателя
    # @option options [String] :model конкретная модель для использования
    # @option options [String] :task номер задачи для решения
    # @option options [Boolean] :keep_existing сохранять существующие решения
    # @option options [Symbol] :log_level уровень логирования
    # @option options [Boolean] :create_empty_on_timeout создавать пустой файл при таймауте или ошибке
    def initialize(tasks_dir, options = {})
      @tasks_dir = tasks_dir
      @model = options[:model]
      @task_number = options[:task]
      @keep_existing = options[:keep_existing]
      @create_empty_on_timeout = options[:create_empty_on_timeout]
      self.log_level = options[:log_level] || :normal
      @models_manager = Models.new
      validate_environment
    end

    # Доступ к менеджеру моделей
    # @return [Models] объект для работы с моделями
    attr_reader :models_manager

    # Возвращает список всех моделей
    # @return [Hash] хеш с моделями
    def models
      @models_manager.all
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

    # Возвращает список моделей Ollama
    # @return [Array<String>] список ключей моделей Ollama
    def ollama_models
      @models_manager.ollama
    end

    # Возвращает API ключ для OpenRouter.ai
    # @return [String] API ключ
    def openrouter_api_key
      @models_manager.openrouter_api_key
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
      models_to_use = select_models_for_task

      models_to_use.each_with_index do |model_key, index|
        model_info = models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
        log "  Модель #{index + 1}/#{models_to_use.size}: #{model_key} (#{model_info['name']})"
        solve_with_model(task_number, content, model_key)
      end
    end

    # Выбирает модели для решения задачи
    # @return [Array<String>] список ключей моделей
    def select_models_for_task
      if @model
        [@model]
      elsif @models_manager.openrouter_available?
        models.keys
      else
        models_list = ollama_models
        log "Используются только локальные модели Ollama: #{models_list.join(', ')}"
        models_list
      end
    end

    # Решает задачу с использованием указанной модели
    # @param task_number [String] номер задачи
    # @param content [String] содержимое задачи
    # @param model_key [String] ключ модели
    def solve_with_model(task_number, content, model_key)
      model_info = models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
      model_name = model_info['name']
      provider = model_info['provider']

      output_file = prepare_output_file(task_number, model_key)
      return if @keep_existing && File.exist?(output_file)

      debug "Решаем задачу #{task_number} с моделью #{model_name} (провайдер: #{provider})"
      log_task_details(content)

      prompt = prepare_prompt(content)

      solve_with_error_handling(task_number, model_name, output_file) do
        raw_solution = call_model_api(prompt, model_key, provider)
        process_model_response(raw_solution, model_name, output_file)
      end
    end

    # Выполняет блок кода с обработкой ошибок и возможностью создания пустых файлов решений
    # @param task_number [String] номер задачи
    # @param model_name [String] имя модели
    # @param output_file [String] путь к файлу для сохранения решения
    # @yield блок кода для выполнения
    def solve_with_error_handling(task_number, model_name, output_file)
      yield
    rescue => e
      handle_solution_error(task_number, model_name, output_file, e)
    end

    # Обрабатывает ошибку при решении задачи
    # @param task_number [String] номер задачи
    # @param model_name [String] имя модели
    # @param output_file [String] путь к файлу для сохранения решения
    # @param error [Exception] возникшая ошибка
    def handle_solution_error(task_number, model_name, output_file, error)
      error "❌ Ошибка при решении задачи #{task_number} с моделью #{model_name}: #{error.message}"

      raise error unless @create_empty_on_timeout

      create_empty_solution_file(output_file, error.message)
      log "✓ Создан пустой файл решения для задачи #{task_number} (#{model_name})"
    end

    # Создает пустой файл решения с комментарием о причине ошибки
    # @param output_file [String] путь к файлу для сохранения
    # @param error_message [String] сообщение об ошибке
    def create_empty_solution_file(output_file, error_message)
      empty_solution = <<~SOLUTION
        # timeout - решение не было получено из-за ошибки
        # #{error_message}
      SOLUTION

      File.write(output_file, empty_solution)
      debug "Создан пустой файл решения: #{output_file}"
    end

    # Подготавливает путь к файлу для сохранения решения
    # @param task_number [String] номер задачи
    # @param model_key [String] ключ модели
    # @return [String] путь к файлу
    def prepare_output_file(task_number, model_key)
      model_info = models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
      model_name = model_info['name']
      model_file_name = Model::ToPath.to_path(model_name)
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

    # Вызывает API OpenRouter.ai
    # @param prompt [String] промпт для отправки
    # @param model_key [String] ключ модели
    # @return [String] ответ модели
    def call_openrouter(prompt, model_key)
      model_info = models[model_key] || { 'name' => model_key, 'provider' => 'openrouter.ai' }
      model_name = model_info['name']

      uri = URI('https://openrouter.ai/api/v1/chat/completions')
      http = prepare_http_client(uri, true)

      debug "Вызываем OpenRouter API с моделью #{model_name}"
      request = prepare_openrouter_request(uri, model_name, prompt)

      response = execute_api_request(http, request)
      process_openrouter_response(response, model_name)
    end

    # Подготавливает HTTP клиент для запроса
    # @param uri [URI] URI для запроса
    # @param use_ssl [Boolean] использовать SSL или нет
    # @return [Net::HTTP] HTTP клиент
    def prepare_http_client(uri, use_ssl = false)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      # Устанавливаем таймаут на соединение и чтение (в секундах)
      http.open_timeout = 10
      http.read_timeout = 180 # 3 минуты на ожидание ответа
      http
    end

    # Выполняет HTTP запрос с обработкой таймаута
    # @param http [Net::HTTP] HTTP клиент
    # @param request [Net::HTTPRequest] HTTP запрос
    # @return [Net::HTTPResponse] HTTP ответ
    def execute_api_request(http, request)
      response = http.request(request)
      debug "Получен ответ от API (статус: #{response.code})"
      response
    rescue Timeout::Error => e
      error "❌ Произошел таймаут при запросе к API: #{e.message}"
      raise e
    rescue => e
      error "❌ Произошла ошибка при запросе к API: #{e.message}"
      raise e
    end

    # Обрабатывает ответ модели и сохраняет решение в файл
    # @param raw_solution [String] ответ модели
    # @param model_name [String] имя модели
    # @param output_file [String] путь к файлу для сохранения решения
    def process_model_response(raw_solution, model_name, output_file)
      # Логируем полученный ответ
      debug "Получено решение от модели #{model_name}"
      debug '---BEGIN MODEL RESPONSE---'
      debug raw_solution
      debug '---END MODEL RESPONSE---'

      # Извлекаем код из блоков кода в ответе
      solution = extract_and_join_code_blocks(raw_solution)

      # Удаляем теги reasoning, если они есть в решении
      solution = remove_reasoning_tags(solution)

      # Сохраняем решение в файл
      File.write(output_file, solution)
      debug "Решение сохранено в файл: #{output_file}"

      # Вывод размера решения
      log "✓ Сохранено решение от #{model_name} (#{solution.bytesize} байт)"
    end

    # Подготавливает запрос к OpenRouter API
    # @param uri [URI] URI для запроса
    # @param model_name [String] имя модели
    # @param prompt [String] промпт для отправки
    # @return [Net::HTTP::Post] HTTP запрос
    def prepare_openrouter_request(uri, model_name, prompt)
      # Создаем запрос
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = "Bearer #{openrouter_api_key}"
      request['HTTP-Referer'] = 'https://github.com/yourusername/human-eval-solver'
      request['X-Title'] = 'Human Eval Solver'

      # Задаем тело запроса
      request_body = {
        model: model_name,
        messages: [
          { role: 'system', content: 'You are a helpful AI assistant. Answer CONCISELY.' },
          { role: 'user', content: prompt }
        ],
        temperature: 0.0,
        max_tokens: 4000
      }

      request.body = request_body.to_json
      request
    end

    # Обрабатывает ответ от OpenRouter API
    # @param response [Net::HTTPResponse] HTTP ответ
    # @param model_name [String] имя модели
    # @return [String] решение
    def process_openrouter_response(response, model_name)
      # Проверяем успешность запроса
      unless response.is_a?(Net::HTTPSuccess)
        error_message = "❌ Ошибка API (статус: #{response.code})"

        begin
          error_data = JSON.parse(response.body)
          error_message += ": #{error_data['error'] || error_data['message'] || 'неизвестная ошибка'}"
        rescue
          error_message += ": #{response.body}"
        end

        error error_message
        raise error_message
      end

      # Парсим ответ
      parsed_response = JSON.parse(response.body)
      debug "Успешно получен ответ от OpenRouter для модели #{model_name}"

      # Проверяем наличие содержимого в ответе
      content = parsed_response.dig('choices', 0, 'message', 'content')
      if content.nil? || content.empty?
        error_message = "❌ Пустой ответ от модели #{model_name}"
        error error_message
        raise error_message
      end

      content
    end

    # Вызывает API Ollama
    # @param prompt [String] промпт для отправки
    # @param model_key [String] ключ модели
    # @return [String] ответ модели
    def call_ollama(prompt, model_key)
      model_info = models[model_key] || { 'name' => model_key, 'provider' => 'ollama' }
      model_name = model_info['name']

      uri = URI("#{OLLAMA_BASE_URL}/api/chat")
      http = prepare_http_client(uri)

      debug "Вызываем Ollama API с моделью #{model_name}"
      request = prepare_ollama_request(uri, model_name, prompt)

      response = execute_api_request(http, request)
      process_ollama_response(response, model_name, uri)
    end

    # Подготавливает запрос к Ollama API
    # @param uri [URI] URI для запроса
    # @param model_name [String] имя модели
    # @param prompt [String] промпт для отправки
    # @return [Net::HTTP::Post] HTTP запрос
    def prepare_ollama_request(uri, model_name, prompt)
      # Создаем запрос
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'

      # Задаем тело запроса
      request_body = {
        model: model_name,
        messages: [
          { role: 'system', content: 'You are a helpful AI assistant. Answer CONCISELY.' },
          { role: 'user', content: prompt }
        ],
        stream: false,
        options: {
          temperature: 0.0,
          num_predict: 4000
        }
      }

      request.body = request_body.to_json
      request
    end

    # Обрабатывает ответ от Ollama API
    # @param response [Net::HTTPResponse] HTTP ответ
    # @param model_name [String] имя модели
    # @param uri [URI] URI запроса
    # @return [String] решение
    def process_ollama_response(response, model_name, uri)
      # Проверяем успешность запроса
      unless response.is_a?(Net::HTTPSuccess)
        error_message = "❌ Ошибка API Ollama (статус: #{response.code})"

        begin
          error_data = JSON.parse(response.body)
          error_message += ": #{error_data['error'] || 'неизвестная ошибка'}"
        rescue
          error_message += ": #{response.body}"
        end

        error error_message
        raise error_message
      end

      # Парсим ответ
      begin
        parsed_response = JSON.parse(response.body)
        debug "Успешно получен ответ от Ollama для модели #{model_name}"
      rescue => e
        error "❌ Ошибка при обработке ответа Ollama: #{e.message}"
        error "URI: #{uri}, Тело ответа: #{response.body}"
        raise e
      end

      # Извлекаем содержимое ответа
      extract_ollama_content(parsed_response, model_name)
    end

    # Извлекает содержимое из ответа Ollama
    # @param parsed_response [Hash] распарсенный ответ
    # @param model_name [String] имя модели
    # @return [String] содержимое ответа
    def extract_ollama_content(parsed_response, model_name)
      content = parsed_response.dig('message', 'content') || parsed_response['response']

      if content.nil? || content.empty?
        error_message = "❌ Пустой ответ от модели Ollama #{model_name}"
        error error_message
        raise error_message
      end

      content
    end

    # Извлекает и объединяет блоки кода из входящего текста
    # @param input [String] входящий текст
    # @return [String] объединенные блоки кода или исходный текст
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

    # Удаляет теги reasoning и их содержимое из кода
    # @param content [String] входящий код
    # @return [String] код без тегов reasoning
    def remove_reasoning_tags(content)
      return content unless content.include?('<reasoning>') && content.include?('</reasoning>')

      # Удаляем все, что находится между тегами <reasoning> и </reasoning>
      new_content = content.gsub(%r{<reasoning>.*?</reasoning>}m, '')

      # Удаляем лишние пустые строки, которые могли остаться
      # Заменяем любую последовательность пустых строк на одну пустую строку
      new_content.gsub(/\n\s*\n+/, "\n\n").gsub(/\A\s*\n+/, "\n")
    end

    # Проверяет окружение на возможность запуска решателя
    def validate_environment
      raise "Каталог #{@tasks_dir} не найден" unless Dir.exist?(@tasks_dir)

      validate_model_environment
    end

    # Проверяет доступность моделей
    def validate_model_environment
      if @model
        validate_specific_model
      else
        validate_default_models
      end
    end

    # Проверяет доступность указанной модели
    def validate_specific_model
      model_info = models[@model] || { 'name' => @model, 'provider' => 'openrouter.ai' }
      provider = model_info['provider']

      return unless provider != 'ollama' && !openrouter_api_key

      raise 'Для использования моделей OpenRouter.ai необходимо указать OPENROUTER_API_KEY в переменных окружения'
    end

    # Проверяет доступность моделей по умолчанию
    def validate_default_models
      # Если модель не указана, проверяем наличие ключа OpenRouter.ai,
      # так как по умолчанию будут использоваться все модели, включая OpenRouter.ai˝
      return if openrouter_api_key

      # Если ключа нет, проверяем наличие хотя бы одной модели Ollama
      ollama_list = ollama_models
      raise 'Нет доступных локальных моделей Ollama и не указан OPENROUTER_API_KEY' if ollama_list.empty?

      log 'API ключ OpenRouter.ai не найден. Будут использоваться только локальные модели Ollama.'
    end
  end
end
