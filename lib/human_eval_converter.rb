# frozen_string_literal: true

require 'json'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'
require_relative 'human_eval/logger'

# Класс для конвертации задач из формата HumanEval в формат для тестирования
class HumanEvalConverter
  include HumanEval::Logger

  def initialize(input_file, output_dir, options = {})
    @input_file = input_file
    @output_dir = output_dir
    @task_number = options[:task_number]
    self.log_level = options[:log_level] || :normal

    validate_environment
  end

  def process
    FileUtils.mkdir_p(@output_dir)
    tasks = read_tasks

    tasks.each do |task|
      next if @task_number && task['task_id'] != "HumanEval/#{@task_number}"

      process_task(task)
    end
  end

  private

  def validate_environment
    raise "Файл #{@input_file} не найден" unless File.exist?(@input_file)
    raise 'Установите переменную OPENROUTER_API_KEY в файле .env' unless ENV.fetch('OPENROUTER_API_KEY', nil)
  end

  def read_tasks
    File.readlines(@input_file).map { |line| JSON.parse(line) }
  end

  def process_task(task)
    task_id = task['task_id'].split('/').last
    description = get_task_description(task)
    tests = get_task_tests(task, description)

    save_task_files(task_id, task, description, tests)
  end

  def get_task_description(task)
    response = call_api(
      File.read('rules/description_prompt.txt'),
      task['prompt']
    )

    response.dig('choices', 0, 'message', 'content')
  end

  def get_task_tests(task, description)
    response = call_api(
      File.read('rules/test_prompt.txt'),
      "#{description}\n\n#{task['prompt']}"
    )

    response.dig('choices', 0, 'message', 'content')
  end

  def call_api(prompt, content)
    uri = URI('https://openrouter.ai/api/v1/chat/completions')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{ENV['OPENROUTER_API_KEY']}"
    request['Content-Type'] = 'application/json'
    request['HTTP-Referer'] = 'https://github.com/yourusername/human-eval-converter'
    request['X-Title'] = 'Human Eval Converter'
    request['OpenAI-Organization'] = 'openrouter'
    request['User-Agent'] = 'Human Eval Converter/1.0.0'
    request['Accept'] = '*/*'
    request['Accept-Encoding'] = 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'
    request['Host'] = 'openrouter.ai'

    request.body = {
      model: 'google/gemini-flash-1.5',
      messages: [{ role: 'user', content: "#{prompt}\n\n#{content}" }],
      temperature: 0.7,
      max_tokens: 1000,
      stream: false
    }.to_json

    response = http.request(request)
    return {} unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  rescue StandardError => e
    error "Ошибка при вызове API: #{e.message}"
    {}
  end

  def save_task_files(task_id, task, description, tests)
    base_path = File.join(@output_dir, "t#{task_id}")

    # Сохраняем JSONL
    File.write("#{base_path}.jsonl", task.to_json)

    # Сохраняем JSON
    File.write("#{base_path}.json", JSON.pretty_generate(task))

    # Сохраняем описание
    File.write("#{base_path}.md", description)

    # Сохраняем тесты
    File.write("#{base_path}-assert.rb", tests)
  end
end 