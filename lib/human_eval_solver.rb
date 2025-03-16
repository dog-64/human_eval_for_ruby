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

    MODELS = {
      'deepseek_deepseek_chat' => { name: 'deepseek/deepseek-chat', provider: 'openrouter.ai' },
      'deepseek_deepseek_chat_free' => { name: 'deepseek/deepseek-chat:free', provider: 'openrouter.ai' },
      'google_gemini_2_0_flash_001' => { name: 'google/gemini-2.0-flash-001', provider: 'openrouter.ai' },
      'google_gemini_2_0_flash_lite_001' => { name: 'google/gemini-2.0-flash-lite-001', provider: 'openrouter.ai' },
      'google_gemini_flash_1_5' => { name: 'google/gemini-flash-1.5', provider: 'openrouter.ai' },
      'meta_llama_llama_3_1_70b_instruct' => { name: 'meta-llama/llama-3.1-70b-instruct', provider: 'openrouter.ai' },
      'qwen_qwen_2_5_coder_32b' => { name: 'qwen/qwen-2.5-coder-32b', provider: 'openrouter.ai' },
      'qwen_qwen_2_5_coder_32b_instruct' => { name: 'qwen/qwen-2.5-coder-32b-instruct:free', provider: 'openrouter.ai' },
      'mistralai_codestral_2501' => { name: 'mistralai/codestral-2501', provider: 'openrouter.ai' },
      'openai_gpt_4o_mini' => { name: 'openai/gpt-4o-mini', provider: 'openrouter.ai' },
      'openai_o3_mini_high' => { name: 'openai/o3-mini-high', provider: 'openrouter.ai' },
      'anthropic_claude_3_5_sonnet' => { name: 'anthropic/claude-3.5-sonnet', provider: 'openrouter.ai' }
    }

    Dotenv.load
    OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']

    def initialize(tasks_dir, options = {})
      @tasks_dir = tasks_dir
      @model = options[:model]
      @task_number = options[:task]
      @keep_existing = options[:keep_existing]
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
      models = @model ? [@model] : MODELS.keys

      models.each_with_index do |model_key, index|
        model_info = MODELS[model_key] || { name: model_key, provider: 'openrouter.ai' }
        log "  Модель #{index + 1}/#{models.size}: #{model_key} (#{model_info[:name]})"
        solve_with_model(task_number, content, model_key)
      end
    end

    def solve_with_model(task_number, content, model_key)
      model_info = MODELS[model_key] || { name: model_key, provider: 'openrouter.ai' }
      model_name = model_info[:name]
      
      model_file_name = model_key.gsub(/[^A-Za-z0-9\/]/, '_')
      output_file = File.join(@tasks_dir, "t#{task_number}-#{model_file_name}.rb")

      if @keep_existing && File.exist?(output_file)
        debug "Пропускаем существующее решение: #{output_file}"
        return
      end

      debug "Решаем задачу #{task_number} с моделью #{model_name} (провайдер: #{model_info[:provider]})"

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

      raw_solution = call_openrouter(prompt, model_key)
      debug "Получено решение от модели #{model_name}"
      debug "---BEGIN MODEL RESPONSE---"
      debug raw_solution
      debug "---END MODEL RESPONSE---"

      solution = extract_and_join_code_blocks(raw_solution)
      if solution.strip.empty?
        error "❌ Модель #{model_name} вернула пустое решение!"
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

    def call_openrouter(prompt, model_key)
      model_info = MODELS[model_key] || { name: model_key, provider: 'openrouter.ai' }
      model_name = model_info[:name]
      
      debug "Вызов OpenRouter API с моделью #{model_name}"
      uri = URI('https://openrouter.ai/api/v1/chat/completions')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "Bearer #{OPENROUTER_API_KEY}"
      request['Content-Type'] = 'application/json'
      request['HTTP-Referer'] = ENV['HTTP_REFERER'] || 'https://github.com/yourusername/human-eval-solver'
      request['X-Title'] = 'Human Eval Solver'

      request.body = {
        model: model_name,
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.1,
        max_tokens: 32000, # 1000 - для всех, 32000 - для o3-mini-high 
        stream: false
      }.to_json

      debug "Ожидаем ответ от API"
      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        error "Ошибка API: #{response.code} - #{response.body}"
        raise "Ошибка API при вызове модели #{model_name}"
      end

      begin
        parsed_response = JSON.parse(response.body)
        content = parsed_response.dig('choices', 0, 'message', 'content')

        if content.nil? || content.empty?
          error "Пустой ответ от API для модели #{model_name}"
          error "Ответ API: #{parsed_response.inspect}"
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
