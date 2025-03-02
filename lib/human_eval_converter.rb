require 'json'
require 'fileutils'
require 'net/http'
require 'uri'

class HumanEvalConverter
  OPENROUTER_API_KEY = ENV['OPENROUTER_API_KEY']
  AI_MODEL = 'mistralai/mistral-7b-instruct'

  def initialize(input_file, output_dir, options = {})
    @input_file = input_file
    @output_dir = output_dir
    @create_rules = options[:create_rules] || false
    @keep_existing = options[:keep_existing] || false
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
    task_id = task['task_id']
    puts "Обработка task_id: #{task_id}"

    # Извлекаем только номер из task_id (например, из "HumanEval/0" получаем "0")
    task_number = task_id.split('/').last

    FileUtils.mkdir_p(@output_dir)

    # Сохраняем исходные данные
    jsonl_path = File.join(@output_dir, "t#{task_number}.jsonl")
    json_path = File.join(@output_dir, "t#{task_number}.json")
    readme_path = File.join(@output_dir, "t#{task_number}.md")
    test_path = File.join(@output_dir, "t#{task_number}_asserts.rb")

    if @keep_existing && (File.exist?(jsonl_path) || File.exist?(json_path))
      puts "Пропускаем существующие файлы в #{@output_dir}"
    else
      puts "Сохраняем JSONL в: #{jsonl_path}"
      File.write(jsonl_path, JSON.generate(task))

      puts "Сохраняем JSON в: #{json_path}"
      File.write(json_path, JSON.pretty_generate(task))
    end

    # Генерируем остальные файлы
    begin
      if @keep_existing && (File.exist?(readme_path) || File.exist?(test_path))
        puts "Пропускаем существующие README и test файлы в #{@output_dir}"
      else
        puts "Создаем README в: #{readme_path}"
        create_task_markdown(@output_dir, task, task_number)

        puts "Создаем test файл в: #{test_path}"
        create_assertions(@output_dir, task, task_number)
      end
    rescue StandardError => e
      puts "Предупреждение: Ошибка при создании дополнительных файлов для #{task_id}: #{e.message}"
      puts "Исходные данные сохранены в: #{jsonl_path} и #{json_path}"
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

  def create_task_markdown(dir, task, task_number)
    file_path = File.join(dir, "t#{task_number}.md")
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

    puts "\nЗапрос к LLM для task_id #{task['task_id']}:"
    puts request.to_json

    # Получаем ответ от LLM
    llm_response = call_openrouter(request[:content])

    content = <<~MARKDOWN
      ## task_id
      #{task['task_id']}

      ## Описание задачи
      #{llm_response}
    MARKDOWN

    File.write(file_path, content)
    puts "\nОтвет от LLM сохранен в: #{file_path}"
  end

  def create_assertions(dir, task, task_number)
    file_path = File.join(dir, "t#{task_number}-asserts.rb")
    return if @keep_existing && File.exist?(file_path)
    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Генерируем тесты для задачи #{task['task_id']}"
    prompt = <<~PROMPT
      Создай 10 тестовых примеров на Ruby для этой задачи:

      Описание задачи:
      #{task['prompt']}

      Формат вывода должен быть в виде вызовов метода с проверкой assert через ==, по одному на строку.
      Используй разные входные данные для каждого теста.
    PROMPT

    assertions = call_openrouter(prompt)
    File.write("#{dir}/t#{task_number}_asserts.rb", assertions)
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
    request['HTTP-Referer'] = 'https://github.com/yourusername/yourrepo'
    request['X-Title'] = 'Human Eval Converter'

    request.body = {
      model: AI_MODEL,
      messages: [{ role: 'user', content: prompt }],
      max_tokens: 1000
    }.to_json

    puts "#{__FILE__}:#{__LINE__} [DEBUG] | Ожидаем ответ от API"
    response = http.request(request)

    unless response.is_a?(Net::HTTPSuccess)
      error_message = "Ошибка API: #{response.code} - #{response.body}"
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | #{error_message}"
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | Запрос: #{request.body}"
      raise error_message
    end

    begin
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | Ответ получен успешно"
      parsed_response = JSON.parse(response.body)
      parsed_response.dig('choices', 0, 'message', 'content') || raise('Пустой ответ от API')
    rescue JSON::ParserError => e
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | Ошибка парсинга JSON: #{e.message}"
      puts "#{__FILE__}:#{__LINE__} [DEBUG] | Тело ответа: #{response.body}"
      raise "Ошибка парсинга ответа API: #{e.message}"
    end
  end
end

# Добавляем опцию в CLI если она используется
if ARGV.include?("--preserve-old")
  options[:preserve_old] = true
end 
