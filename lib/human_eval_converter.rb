require 'json'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'

class HumanEvalConverter
  # Загружаем переменные окружения из .env файла
  Dotenv.load

  OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']
  AI_MODEL = ENV['AI_MODEL'] || 'google/gemini-flash-1.5'
  
  LOG_LEVELS = {
    none: 0,
    normal: 1,
    debug: 2
  }

  private

  def log(message, level = :normal)
    return if @log_level < LOG_LEVELS[level]
    
    # Получаем информацию о вызове
    # Для debug используем глубину 2, чтобы получить место вызова debug
    depth = level == :debug ? 2 : 1
    caller_info = caller_locations(depth,1).first
    file = caller_info ? File.basename(caller_info.path) : ''
    line = caller_info ? caller_info.lineno : ''
    
    # Форматируем сообщение в зависимости от уровня лога
    formatted_message = if level == :debug
      "#{file}:#{line} [DEBUG] | #{message}"
    else
      message
    end
    
    puts formatted_message
  end

  def debug(message)
    log(message, :debug)
  end

  public

  def initialize(input_file, output_dir, options = {})
    @input_file = input_file
    @output_dir = output_dir
    @create_rules = options[:create_rules] || false
    @keep_existing = options[:keep_existing] || false
    @preserve_old = options[:preserve_old] || false
    @task_number = options[:task_number]
    @log_level = if options[:log_level]
      LOG_LEVELS[options[:log_level].to_sym] || LOG_LEVELS[:normal]
    else
      LOG_LEVELS[:normal]
    end
    validate_environment
  end

  def process
    debug "Начинаем обработку задач"
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
      log "Предупреждение: Ошибка при создании дополнительных файлов для #{task_id}: #{e.message}"
      log "Исходные данные сохранены в: #{jsonl_path} и #{json_path}"
    end
  end

  private

  def validate_environment
    unless File.exist?(@input_file)
      raise "Файл #{@input_file} не найден"
    end

    unless ENV['OPENROUTER_API_KEY']
      raise "Установите переменную OPENROUTER_API_KEY в файле .env"
    end
  end

  def read_tasks
    debug "Читаем файл #{@input_file}"
    File.readlines(@input_file).map { |line| JSON.parse(line) }
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
      role: "user",
      content: "#{escaped_prompt}\n\n#{escaped_rules}"
    }

    debug "Запрос к LLM для task_id #{task['task_id']}:"
    debug request.to_json

    # Получаем ответ от LLM
    llm_response = call_openrouter(request[:content])

    content = <<~MARKDOWN
      ## task_id
      #{task['task_id']}

      ## Описание задачи
      #{llm_response}
    MARKDOWN

    File.write(file_path, content)
    debug "Ответ от LLM сохранен в: #{file_path}"
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
    debug "Запрос к LLM для генерации тестов task_id #{task['task_id']}:\n#{request}"
    
    assertions = call_openrouter(request)
    debug "Ответ от LLM (тесты):\n#{assertions}"
    
    File.write(file_path, assertions)
    debug "Тесты сохранены в #{file_path}"
  end

  def call_openrouter(prompt)
    debug "Вызов OpenRouter API"
    uri = URI('https://openrouter.ai/api/v1/chat/completions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{OPENROUTER_API_KEY}"
    request['Content-Type'] = 'application/json'
    request['HTTP-Referer'] = 'https://github.com/yourusername/yourrepo'
    request['X-Title'] = 'Human Eval Converter'

    request.body = {
      model: AI_MODEL,
      messages: [{ role: 'user', content: prompt }]
    }.to_json

    debug "Ожидаем ответ от API"
    response = http.request(request)

    unless response.is_a?(Net::HTTPSuccess)
      error_message = "Ошибка API: #{response.code} - #{response.body}"
      debug error_message
      debug "Запрос: #{request.body}"
      raise error_message
    end

    begin
      debug "Ответ получен успешно"
      parsed_response = JSON.parse(response.body)
      parsed_response.dig('choices', 0, 'message', 'content') || raise('Пустой ответ от API')
    rescue JSON::ParserError => e
      debug "Ошибка парсинга JSON: #{e.message}"
      debug "Тело ответа: #{response.body}"
      raise "Ошибка парсинга ответа API: #{e.message}"
    end
  end
end 
