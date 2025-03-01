require 'json'
require 'fileutils'
require 'net/http'
require 'uri'

class HumanEvalConverter
  OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']
  AI_MODEL = 'mistralai/mistral-7b-instruct'
  
  def initialize(options = {})
    @preserve_old = options[:preserve_old] || false
    @src_file = '_src/HumanEval.jsonl'
    validate_environment
  end

  def process
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Начинаем обработку задач"
    read_tasks.each do |task|
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | Обработка задачи #{task['task_id']}"
      process_task(task)
    end
  end

  def process_task(task)
    puts "Processing task: #{task['task_id']}"
    task_dir = "tasks/t#{task['task_id']}"
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Создаем каталог #{task_dir}"
    FileUtils.rm_rf(task_dir) if Dir.exist?(task_dir)
    FileUtils.mkdir_p(task_dir)

    create_task_markdown(task_dir, task)
    create_assertions(task_dir, task)

    if @preserve_old
      # Добавляем временную метку к имени файла
      timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
      base_name = File.basename(output_file, ".*")
      ext = File.extname(output_file)
      output_file = "#{File.dirname(output_file)}/#{base_name}_#{timestamp}#{ext}"
    end
  end

  private

  def validate_environment
    unless File.exist?(@src_file)
      raise "Файл #{@src_file} не найден. Создайте каталог _src и поместите в него файл HumanEval.jsonl"
    end

    unless ENV['OPENROUTER_API_KEY']
      raise "Установите переменную окружения OPENROUTER_API_KEY"
    end
  end

  def read_tasks
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Читаем файл #{@src_file}"
    File.readlines(@src_file).map { |line| JSON.parse(line) }
  end

  def create_task_markdown(task_dir, task)
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Конвертируем описание задачи в Ruby"
    ruby_description = convert_to_ruby(task['prompt'])
    
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Создаем task.md"
    content = <<~MARKDOWN
      ## task_id
      #{task['task_id']}

      ## Описание задачи
      #{ruby_description}

      ## entry_point
      #{task['entry_point']}

      ## canonical_solution
      ```ruby
      #{convert_to_ruby(task['canonical_solution'])}
      ```

      ## Примеры
      ```ruby
      #{convert_to_ruby(task['test'])}
      ```
    MARKDOWN

    File.write("#{task_dir}/task.md", content)
  end

  def create_assertions(task_dir, task)
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Генерируем тесты для задачи #{task['task_id']}"
    prompt = <<~PROMPT
      Создай 10 тестовых примеров на Ruby для этой задачи:
      
      Описание задачи:
      #{task['prompt']}
      
      Формат вывода должен быть в виде вызовов метода с проверкой через ==, по одному на строку.
      Используй разные входные данные для каждого теста.
    PROMPT

    assertions = call_openrouter(prompt)
    File.write("#{task_dir}/asserts.rb", assertions)
  end

  def convert_to_ruby(python_code)
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Отправляем запрос на конвертацию кода"
    prompt = <<~PROMPT
      Переведи этот код/описание с Python на Ruby 3.2:
      #{python_code}
      
      Убедись, что код соответствует стилю Ruby и использует его идиомы.
    PROMPT

    call_openrouter(prompt)
  end

  def call_openrouter(prompt)
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Вызов OpenRouter API"
    uri = URI('https://openrouter.ai/api/v1/chat/completions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{OPENROUTER_API_KEY}"
    request['Content-Type'] = 'application/json'
    
    request.body = {
      model: AI_MODEL,
      messages: [{ role: 'user', content: prompt }]
    }.to_json

    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Ожидаем ответ от API"
    response = http.request(request)
    
    unless response.is_a?(Net::HTTPSuccess)
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | Ошибка API: #{response.code}"
      raise "Ошибка API: #{response.code} - #{response.body}"
    end

    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Ответ получен успешно"
    JSON.parse(response.body)['choices'][0]['message']['content']
  end
end

# Добавляем опцию в CLI если она используется
if ARGV.include?("--preserve-old")
  options[:preserve_old] = true
end 