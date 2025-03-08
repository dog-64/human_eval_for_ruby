require 'json'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'
require_relative 'logger'
require 'strscan'

module HumanEval
  class Solver
    include HumanEval::Logger

    MODELS = %w[
      google/gemini-flash-1.5 
      deepseek/deepseek-chat:free 
      qwen/qwen-2.5-coder-32b-instruct:free 
      qwen/qwen-2.5-coder-32b 
      google/gemini-2.0-flash-001
      meta-llama/llama-3.1-70b-instruct
 
      openai/gpt-4o-mini 
      openai/gpt-4o 
      anthropic/claude-3.5-sonnet
    ]

    Dotenv.load
    OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']

    def initialize(tasks_dir, options = {})
      @tasks_dir = tasks_dir
      @model = options[:model]
      @task_number = options[:task]
      self.log_level = options[:log_level] || :normal
      validate_environment
    end

    def process
      debug "Начинаем обработку задач"
      task_files = if @task_number
        [File.join(@tasks_dir, "t#{@task_number}.md")]
      else
        Dir[File.join(@tasks_dir, "t*.md")].sort
      end

      total_tasks = task_files.size
      log "Найдено задач: #{total_tasks}"

      task_files.each_with_index do |file, index|
        task_number = File.basename(file, '.md').sub('t', '')
        log "Обработка задачи #{task_number} (#{index + 1}/#{total_tasks})"
        process_task(file)
      end

      log "Обработка задач завершена"
    end

    private

    def process_task(file)
      task_number = File.basename(file, '.md').sub('t', '')
      debug "Детали задачи #{task_number}:"

      content = File.read(file)
      models = @model ? [@model] : MODELS

      models.each_with_index do |model, index|
        log "  Модель #{index + 1}/#{models.size}: #{model}"
        solve_with_model(task_number, content, model)
      end
    end

    def solve_with_model(task_number, content, model)
      model_file_name = model.gsub(/[^A-Za-z0-9\/]/, '_')
      model_file_name = model_file_name.gsub('/', '_')
      output_file = File.join(@tasks_dir, "t#{task_number}-#{model_file_name}.rb")

      debug "Решаем задачу #{task_number} с моделью #{model}"

      debug "Исходное содержимое файла:"
      debug "---BEGIN ORIGINAL CONTENT---"
      debug content
      debug "---END ORIGINAL CONTENT---"

      solver_prompt = File.read(File.join('rules', 'model_solver_prompt.txt'))
      debug "Загружен промпт для решения:"
      debug "---BEGIN SOLVER PROMPT---"
      debug solver_prompt
      debug "---END SOLVER PROMPT---"

      prompt = <<~PROMPT
        #{solver_prompt}
        
        #{content}
      PROMPT

      debug "Полный промпт для отправки:"
      debug "---BEGIN FULL PROMPT---"
      debug prompt
      debug "---END FULL PROMPT---"

      raw_solution = call_openrouter(prompt, model)
      debug "Получено решение от модели #{model}"
      debug "---BEGIN MODEL RESPONSE---"
      debug raw_solution
      debug "---END MODEL RESPONSE---"

      solution = extract_and_join_code_blocks(raw_solution)
      if solution.strip.empty?
        error "❌ Модель #{model} вернула пустое решение!"
        error "Полный ответ модели:"
        error raw_solution
        return
      end

      debug "Извлеченное решение:"
      debug "---BEGIN EXTRACTED SOLUTION---"
      debug solution
      debug "---END EXTRACTED SOLUTION---"

      File.write(output_file, solution)
      debug "Решение сохранено в #{output_file}"
    end

    def call_openrouter(prompt, model)
      debug "Вызов OpenRouter API с моделью #{model}"
      uri = URI('https://openrouter.ai/api/v1/chat/completions')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "Bearer #{OPENROUTER_API_KEY}"
      request['Content-Type'] = 'application/json'
      request['HTTP-Referer'] = ENV['HTTP_REFERER'] || 'https://github.com/yourusername/human-eval-solver'
      request['X-Title'] = 'Human Eval Solver'

      request.body = {
        model: model,
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.7,
        max_tokens: 1000,
        stream: false
      }.to_json

      debug "Ожидаем ответ от API"
      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        error "Ошибка API: #{response.code} - #{response.body}"
        raise "Ошибка API при вызове модели #{model}"
      end

      begin
        parsed_response = JSON.parse(response.body)
        content = parsed_response.dig('choices', 0, 'message', 'content')

        if content.nil? || content.empty?
          error "Пустой ответ от API для модели #{model}"
          raise "Пустой ответ от API"
        end

        content.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      rescue JSON::ParserError => e
        error "Ошибка парсинга JSON: #{e.message}"
        raise "Ошибка парсинга ответа API: #{e.message}"
      end
    end

    def extract_and_join_code_blocks(input)
      return input unless input.include?('```ruby') || input.include?('```rb')

      # Находим все фрагменты, обрамлённые тройными обратными кавычками.
      # Регулярное выражение:
      # - Ищет "```", возможно с пробелами и указанием языка до первого переноса строки.
      # - Затем не жадно захватывает содержимое кода.
      # - Ищет закрывающие "```", перед которыми могут быть пробелы.
      code_blocks = input.scan(/```[^\n]*\n(.*?)\s*```/m).flatten
      # Объединяем найденные блоки в один результат с переводами строк.
      code_blocks.join("\n")
    end

    def validate_environment
      unless Dir.exist?(@tasks_dir)
        raise "Каталог #{@tasks_dir} не найден"
      end

      unless ENV['OPENROUTER_API_KEY']
        raise "Установите переменную OPENROUTER_API_KEY в файле .env"
      end
    end
  end
end 
