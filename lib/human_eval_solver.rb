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
      'openai_o3_mini_high' => { name: 'openai/o3-mini-high', provider: 'openrouter.ai', note: 'дорогой, медленный' },
      'anthropic_claude_3_5_sonnet' => { name: 'anthropic/claude-3.5-sonnet', provider: 'openrouter.ai' },
      
      'ollama_llama3_2' => { name: 'llama3.2', provider: 'ollama' },
      'ollama_codellama' => { name: 'codellama', provider: 'ollama', note: 'CodeLlama 7B https://ollama.com/library/codellama' },
      'ollama_mistral' => { name: 'mistral', provider: 'ollama' },
      'ollama_phi3' => { name: 'phi3', provider: 'ollama' },
      'ollama_gemma' => { name: 'gemma', provider: 'ollama' }
    }

    Dotenv.load
    OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']
    OLLAMA_BASE_URL = ENV['OLLAMA_BASE_URL'] || 'http://localhost:11434'

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
        # Проверяем, начинается ли задача с 't'
        task_name = @task_number.start_with?('t') ? @task_number : "t#{@task_number}"
        [File.join(@tasks_dir, "#{task_name}.md")]
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
      
      # Определяем, какие модели использовать
      if @model
        models = [@model]
      else
        # Если ключ OpenRouter.ai не установлен, используем только модели Ollama
        if ENV['OPENROUTER_API_KEY']
          models = MODELS.keys
        else
          models = MODELS.select { |_, info| info[:provider] == 'ollama' }.keys
          log "Используются только локальные модели Ollama: #{models.join(', ')}"
        end
      end

      models.each_with_index do |model_key, index|
        model_info = MODELS[model_key] || { name: model_key, provider: 'openrouter.ai' }
        log "  Модель #{index + 1}/#{models.size}: #{model_key} (#{model_info[:name]})"
        solve_with_model(task_number, content, model_key)
      end
    end

    def solve_with_model(task_number, content, model_key)
      model_info = MODELS[model_key] || { name: model_key, provider: 'openrouter.ai' }
      model_name = model_info[:name]
      provider = model_info[:provider]
      
      model_file_name = model_key.gsub(/[^A-Za-z0-9\/]/, '_')
      output_file = File.join(@tasks_dir, "t#{task_number}-#{model_file_name}.rb")

      if @keep_existing && File.exist?(output_file)
        debug "Пропускаем существующее решение: #{output_file}"
        return
      end

      debug "Решаем задачу #{task_number} с моделью #{model_name} (провайдер: #{provider})"

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

      # Выбираем API в зависимости от провайдера
      raw_solution = case provider
                     when 'ollama'
                       call_ollama(prompt, model_key)
                     else # по умолчанию используем openrouter.ai
                       call_openrouter(prompt, model_key)
                     end

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

    def call_ollama(prompt, model_key)
      model_info = MODELS[model_key] || { name: model_key, provider: 'ollama' }
      model_name = model_info[:name]
      
      debug "Вызов Ollama API с моделью #{model_name}"
      uri = URI("#{OLLAMA_BASE_URL}/api/chat")
      http = Net::HTTP.new(uri.host, uri.port)
      
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'

      request_body = {
        model: model_name,
        messages: [{ role: 'user', content: prompt }],
        stream: false,
        options: {
          temperature: 0.1,
          num_predict: 4096
        }
      }
      
      debug "Запрос к Ollama API:"
      debug request_body.to_json
      
      request.body = request_body.to_json

      debug "Ожидаем ответ от Ollama API"
      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        error "Ошибка Ollama API: #{response.code} - #{response.body}"
        debug "URL запроса: #{uri}"
        debug "Доступные модели Ollama можно посмотреть с помощью команды: ollama list"
        raise "Ошибка Ollama API при вызове модели #{model_name}"
      end

      begin
        parsed_response = JSON.parse(response.body)
        debug "Ответ от Ollama API:"
        debug parsed_response.to_json
        
        content = parsed_response.dig('message', 'content')

        if content.nil? || content.empty?
          error "Пустой ответ от Ollama API для модели #{model_name}"
          error "Ответ API: #{parsed_response.inspect}"
          
          # Попробуем найти содержимое в другом месте в ответе
          if parsed_response.key?('response')
            debug "Найдено поле 'response' в ответе API"
            content = parsed_response['response']
          end
          
          if content.nil? || content.empty?
            raise "Пустой ответ от Ollama API"
          end
        end

        content.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
      rescue JSON::ParserError => e
        error "Ошибка парсинга JSON: #{e.message}"
        error "Тело ответа: #{response.body}"
        raise "Ошибка парсинга ответа Ollama API: #{e.message}"
      end
    end

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
      code_blocks.join("\n")
    end

    def validate_environment
      unless Dir.exist?(@tasks_dir)
        raise "Каталог #{@tasks_dir} не найден"
      end

      if @model
        model_info = MODELS[@model] || { name: @model, provider: 'openrouter.ai' }
        provider = model_info[:provider]
        
        case provider
        when 'openrouter.ai'
          unless ENV['OPENROUTER_API_KEY']
            raise "Установите переменную OPENROUTER_API_KEY в файле .env для использования моделей OpenRouter.ai"
          end
        end
      else
        # Если модель не указана, проверяем наличие ключа OpenRouter.ai,
        # так как по умолчанию будут использоваться все модели, включая OpenRouter.ai
        unless ENV['OPENROUTER_API_KEY']
          log "ВНИМАНИЕ: Переменная OPENROUTER_API_KEY не установлена в файле .env"
          log "Будут использоваться только локальные модели Ollama"
          
          # Фильтруем только модели Ollama
          models_to_use = MODELS.select { |_, info| info[:provider] == 'ollama' }
          if models_to_use.empty?
            raise "Нет доступных локальных моделей Ollama. Установите OPENROUTER_API_KEY для использования моделей OpenRouter.ai"
          end
        end
      end
    end
  end
end 
