require 'json'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'
require 'pry'
require_relative 'logger'

# Класс HumanEvalConverter предназначен для конвертации задач из формата human-eval в отдельные файлы
# Выполняет чтение исходных данных, создание описаний и тестов с использованием языковых моделей
# через API OpenRouter, и сохранение результатов в указанный каталог
class HumanEvalConverter
  include HumanEval::Logger

  # Загружаем переменные окружения из .env файла
  Dotenv.load

  OPENROUTER_API_KEY = ENV.fetch('OPENROUTER_API_KEY', nil)
  AI_MODEL = ENV['AI_MODEL'] || 'google/gemini-flash-1.5'

  def initialize(input_file, output_dir, options = {})
    @input_file = input_file
    @output_dir = output_dir
    @create_rules = options[:create_rules] || false
    @keep_existing = options[:keep_existing] || false
    @preserve_old = options[:preserve_old] || false
    @task_number = options[:task_number]
    self.log_level = options[:log_level] || :normal
    validate_environment
  end

  def process
    debug 'Начинаем обработку задач'
    tasks = read_tasks

    if @task_number
      task = tasks.find { |t| t['task_id'] == "HumanEval/#{@task_number}" }
      if task
        process_task(task)
      else
        log "Задача с номером #{@task_number} не найдена"
      end
    else
      tasks.each do |task|
        debug "Обработка задачи #{task['task_id']}"
        process_task(task)
      end
    end
  end

  def process_task(task)
    task_id = task['task_id']
    log "Обработка task_id: #{task_id}"

    # Извлекаем только номер из task_id (например, из "HumanEval/0" получаем "0")
    task_number = task_id.split('/').last

    FileUtils.mkdir_p(@output_dir)

    # Сохраняем исходные данные
    jsonl_path = File.join(@output_dir, "t#{task_number}.jsonl")
    json_path = File.join(@output_dir, "t#{task_number}.json")
    readme_path = File.join(@output_dir, "t#{task_number}.md")
    test_path = File.join(@output_dir, "t#{task_number}-assert.rb")

    if @keep_existing && (File.exist?(jsonl_path) || File.exist?(json_path))
      debug "Пропускаем существующие файлы в #{@output_dir}"
    else
      debug "Сохраняем JSONL в #{jsonl_path}"
      File.write(jsonl_path, JSON.generate(task))

      debug "Сохраняем JSON в #{json_path}"
      File.write(json_path, JSON.pretty_generate(task))
    end

    # Генерируем остальные файлы
    begin
      if @keep_existing && (File.exist?(readme_path) || File.exist?(test_path))
        debug "Пропускаем существующие README и test файлы в #{@output_dir}"
      else
        debug "Создаем описание задачи в #{readme_path}"
        description = create_task_markdown(task)

        debug "Создаем test файл в #{test_path}"
        create_assertions(@output_dir, task, task_number, description)
      end
    rescue StandardError => e
      error "Ошибка при создании дополнительных файлов для #{task_id}: #{e.message}"
      error "Исходные данные сохранены в: #{jsonl_path} и #{json_path}"
    end
  end

  private

  def validate_environment
    raise "Файл #{@input_file} не найден" unless File.exist?(@input_file)
    raise 'Установите переменную OPENROUTER_API_KEY в файле .env' unless OPENROUTER_API_KEY
  end

  def read_tasks
    debug "Читаем файл #{@input_file}"
    content = File.read(@input_file)
    content.split("\n").map { |line| JSON.parse(line) }
  end

  def create_task_markdown(task)
    task_number = task['task_id'].split('/').last
    file_path = File.join(@output_dir, "t#{task_number}.md")
    return if @keep_existing && File.exist?(file_path)

    prompt_path = File.join('rules', 'description_prompt.txt')
    prompt = File.read(prompt_path)

    # Экранируем специальные символы в промпте и контенте
    escaped_prompt = task['prompt'].gsub('"', '\"').gsub("\n", '\n')
    escaped_rules = prompt.gsub('"', '\"').gsub("\n", '\n')

    request = {
      role: 'user',
      content: "#{escaped_prompt}\n\n#{escaped_rules}"
    }

    debug "Запрос к LLM для task_id #{task['task_id']}:"
    debug "Промпт задачи: #{escaped_prompt}"
    debug "Правила: #{escaped_rules}"
    debug "Полный запрос: #{request.to_json}"

    llm_response = call_openrouter(request[:content])
    debug "Получен ответ от LLM: #{llm_response}"

    content = <<~MARKDOWN
      ## task_id
      #{task['task_id']}

      ## Описание задачи
      #{llm_response}
    MARKDOWN

    debug "Сохраняем описание в файл: #{file_path}"
    File.write(file_path, content)
    debug 'Описание сохранено'
    llm_response
  end

  def create_assertions(dir, task, task_number, description)
    file_path = File.join(dir, "t#{task_number}-assert.rb")
    return if @keep_existing && File.exist?(file_path)

    debug "Генерируем тесты для задачи #{task['task_id']}"

    prompt_path = File.join('rules', 'test_prompt.txt')
    prompt = File.read(prompt_path)

    request = <<~PROMPT
      #{task['prompt']}

      Описание задачи на русском языке:
      #{description}

      #{prompt}
    PROMPT

    debug "Запрос к LLM для генерации тестов task_id #{task['task_id']}"
    debug "Промпт задачи: #{task['prompt']}"
    debug "Описание: #{description}"
    debug "Правила: #{prompt}"
    debug "Полный запрос: #{request}"

    assertions = call_openrouter(request)
    debug "Получен ответ от LLM: #{assertions}"

    debug "Сохраняем тесты в файл: #{file_path}"
    File.write(file_path, assertions)
    debug 'Тесты сохранены'
    assertions
  end

  def call_openrouter(prompt)
    debug 'Вызов OpenRouter API'
    uri = URI('https://openrouter.ai/api/v1/chat/completions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{OPENROUTER_API_KEY}"
    request['Content-Type'] = 'application/json'
    request['HTTP-Referer'] = ENV['HTTP_REFERER'] || 'https://github.com/yourusername/human-eval-converter'
    request['X-Title'] = 'Human Eval Converter'
    request['OpenAI-Organization'] = 'openrouter'
    request['User-Agent'] = 'Human Eval Converter/1.0.0'

    request.body = {
      model: AI_MODEL,
      messages: [{ role: 'user', content: prompt }],
      temperature: 0.7,
      max_tokens: 1000,
      stream: false
    }.to_json

    debug 'Запрос к API:'
    debug request.body

    debug 'Ожидаем ответ от API'
    response = http.request(request)

    debug "Получен ответ с кодом: #{response.code}"
    debug "Заголовки ответа: #{response.to_hash}"

    begin
      debug 'Парсим ответ'
      # Безопасно выводим тело ответа, экранируя проблемные символы
      debug "Тело ответа: #{response.body.inspect}"

      parsed_response = JSON.parse(response.body)
      debug "Распарсенный ответ: #{parsed_response.inspect}"

      content = parsed_response.dig('choices', 0, 'message', 'content')
      if content.nil? || content.empty?
        error 'Пустой ответ от API'
        error "Полный ответ: #{parsed_response.inspect}"
        raise 'Пустой ответ от API'
      end

      # Принудительно конвертируем контент в UTF-8
      content = content.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      debug "Извлечено содержимое ответа: #{content.inspect}"
      content
    rescue JSON::ParserError => e
      error "Ошибка парсинга JSON: #{e.message}"
      error "Тело ответа: #{response.body.inspect}"
      raise "Ошибка парсинга ответа API: #{e.message}"
    end
  end
end
