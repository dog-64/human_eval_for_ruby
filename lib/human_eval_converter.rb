# frozen_string_literal: true

require 'json'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'
require 'pry'
require_relative 'human_eval/logger'

class HumanEvalConverter
  include HumanEval::Logger

  class Error < StandardError; end
  class APIError < Error; end
  class EmptyResponseError < APIError; end

  # Загружаем переменные окружения из .env файла
  Dotenv.load

  OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']
  AI_MODEL = ENV['AI_MODEL'] || 'anthropic/claude-3-sonnet-20240229'
  
  def initialize(input_file, output_dir, options = {})
    @input_file = input_file
    @output_dir = output_dir
    @options = options
    @keep_existing = options[:keep_existing]
    self.log_level = options[:log_level] || 'info'
    @base_dir = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    
    unless OPENROUTER_API_KEY
      raise Error, "Установите переменную OPENROUTER_API_KEY в файле .env"
    end
    
    validate_paths!
  end

  def process
    debug "Начинаем обработку задач"
    tasks = read_tasks
    
    if @options[:task_number]
      task = tasks.find { |t| t['task_id'] == "HumanEval/#{@options[:task_number]}" }
      if task
        process_task(task)
      else
        log "Задача с номером #{@options[:task_number]} не найдена"
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

    # Предварительно обрабатываем символы новой строки
    jsonl_task = task.transform_values { |v| v.is_a?(String) ? v.gsub("\n", "\\n") : v }
    
    # Сохраняем файлы в определенном порядке
    debug "Сохраняем JSONL в #{jsonl_path}"
    File.write(jsonl_path, JSON.dump(jsonl_task)) unless @keep_existing && File.exist?(jsonl_path)

    debug "Сохраняем JSON в #{json_path}"
    File.write(json_path, JSON.pretty_generate(jsonl_task)) unless @keep_existing && File.exist?(json_path)

    begin
      unless @keep_existing && (File.exist?(readme_path) || File.exist?(test_path))
        debug "Создаем описание задачи"
        description = create_task_markdown(task)
        debug "Сохраняем описание в файл: #{readme_path}"
        File.write(readme_path, <<~MARKDOWN)
          ## task_id
          #{task['task_id']}

          ## Описание задачи
          #{description}
        MARKDOWN

        debug "Создаем тесты"
        assertions = create_assertions(task, task_number, description)
        debug "Сохраняем тесты в файл: #{test_path}"
        File.write(test_path, assertions)
      else
        debug "Пропускаем существующие README и test файлы в #{@output_dir}"
      end
    rescue StandardError => e
      error "Ошибка при создании дополнительных файлов для #{task_id}: #{e.message}"
      error "Исходные данные сохранены в: #{jsonl_path} и #{json_path}"
      raise e
    end
  end

  def create_task_markdown(task)
    prompt = File.read('rules/description_prompt.txt')
    
    # Экранируем специальные символы в промпте и контенте
    escaped_prompt = task['prompt'].gsub('"', '\"').gsub("\n", '\n')
    escaped_rules = prompt.gsub('"', '\"').gsub("\n", '\n')
    
    request = {
      role: "user",
      content: "#{escaped_prompt}\n\n#{escaped_rules}"
    }

    debug "Запрос к LLM для task_id #{task['task_id']}:"
    debug "Промпт задачи: #{escaped_prompt}"
    debug "Правила: #{escaped_rules}"
    debug "Полный запрос: #{request.to_json}"

    llm_response = call_openrouter(request[:content])
    debug "Получен ответ от LLM: #{llm_response}"
    llm_response
  end

  def create_assertions(task, task_number, description)
    debug "Генерируем тесты для задачи #{task['task_id']}"
    
    prompt = File.read('rules/test_prompt.txt')
    
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
    assertions
  end

  private

  def validate_paths!
    unless File.exist?(@input_file)
      raise Error, "Входной файл не найден: #{@input_file}"
    end

    expanded_output = File.expand_path(@output_dir)
    unless expanded_output.start_with?(@base_dir)
      raise SecurityError, "Попытка доступа к директории вне рабочей директории: #{@output_dir}"
    end
  end

  def safe_path_join(*parts)
    path = File.join(*parts)
    expanded = File.expand_path(path)
    unless expanded.start_with?(@base_dir)
      raise SecurityError, "Попытка доступа к файлу вне рабочей директории: #{path}"
    end
    path
  end

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

  def call_openrouter(prompt)
    debug "Вызов OpenRouter API"
    uri = URI('https://openrouter.ai/api/v1/chat/completions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{OPENROUTER_API_KEY}"
    request['Content-Type'] = 'application/json'
    request['Http-Referer'] = ENV['HTTP_REFERER'] || 'https://github.com/yourusername/human-eval-converter'
    request['X-Title'] = 'Human Eval Converter'
    request['Openai-Organization'] = 'openrouter'
    request['User-Agent'] = 'Human Eval Converter/1.0.0'

    request.body = {
      model: AI_MODEL,
      messages: [{ role: 'user', content: prompt }],
      temperature: 0.7,
      max_tokens: 1000,
      stream: false
    }.to_json

    debug "Запрос к API:"
    debug request.body

    debug "Ожидаем ответ от API"
    response = http.request(request)

    debug "Получен ответ с кодом: #{response.code}"
    debug "Заголовки ответа: #{response.to_hash}"

    unless response.is_a?(Net::HTTPSuccess)
      error "Ошибка API: #{response.code} - #{response.body}"
      raise "Ошибка API при вызове модели #{AI_MODEL}: #{response.code} - #{response.body}"
    end

    begin
      debug "Парсим ответ"
      debug "Тело ответа: #{response.body.inspect}"
      
      parsed_response = JSON.parse(response.body)
      debug "Распарсенный ответ: #{parsed_response.inspect}"
      
      if parsed_response['choices'].nil? || parsed_response['choices'].empty?
        error "Получен пустой ответ от API: #{parsed_response.inspect}"
        raise "Пустой ответ от API при вызове модели #{AI_MODEL}"
      end

      content = parsed_response['choices'][0]['message']['content']
      if content.nil? || content.empty?
        error "Получен пустой контент от API: #{parsed_response.inspect}"
        raise "Пустой ответ от API при вызове модели #{AI_MODEL}"
      end

      content
    rescue JSON::ParserError => e
      error "Ошибка парсинга ответа API: #{e.message}"
      error "Тело ответа: #{response.body.inspect}"
      raise "Ошибка API: не удалось распарсить ответ - #{e.message}"
    end
  end
end 
