# frozen_string_literal: true

require 'spec_helper'
require 'human_eval/converter'
require 'webmock/rspec'

RSpec.describe HumanEvalConverter do
  let(:input_file) { 'spec/fixtures/test_tasks.jsonl' }
  let(:output_dir) { 'spec/tmp/output' }
  let(:options) { { log_level: :debug } }
  let(:converter) { described_class.new(input_file, output_dir, options) }

  before(:each) do
    # Создаем временную директорию для тестов
    FileUtils.mkdir_p(output_dir)
    FileUtils.mkdir_p('spec/fixtures')

    # Создаем тестовый файл с задачами
    File.write(input_file, <<~JSONL
      {"task_id": "HumanEval/0", "prompt": "Test prompt 0", "entry_point": "test_func"}
      {"task_id": "HumanEval/1", "prompt": "Test prompt 1", "entry_point": "test_func"}
    JSONL
    )

    # Создаем тестовый файл с правилами
    FileUtils.mkdir_p('rules')
    File.write('rules/description_prompt.txt', 'Description rules')
    File.write('rules/test_prompt.txt', 'Test rules')

    # Мокаем переменные окружения
    allow(ENV).to receive(:fetch).with('OPENROUTER_API_KEY', nil).and_return('test_key')

    # Мокаем запросы к OpenRouter API
    stub_request(:post, 'https://openrouter.ai/api/v1/chat/completions')
      .to_return(
        status: 200,
        body: {
          choices: [
            {
              message: {
                content: 'Test response'
              }
            }
          ]
        }.to_json
      )
  end

  after(:each) do
    # Удаляем временные файлы после тестов
    FileUtils.rm_rf(output_dir)
    FileUtils.rm_rf('spec/fixtures')
    FileUtils.rm_rf('rules')
  end

  describe '#initialize' do
    it 'создает экземпляр с правильными параметрами' do
      expect(converter.instance_variable_get(:@input_file)).to eq(input_file)
      expect(converter.instance_variable_get(:@output_dir)).to eq(output_dir)
      expect(converter.instance_variable_get(:@log_level)).to eq(:debug)
    end

    it 'выбрасывает исключение, если входной файл не существует' do
      expect {
        described_class.new('nonexistent.jsonl', output_dir)
      }.to raise_error(/Файл.*не найден/)
    end

    it 'выбрасывает исключение, если OPENROUTER_API_KEY не установлен' do
      # Сначала очищаем все моки
      RSpec::Mocks.space.proxy_for(ENV).reset

      # Теперь устанавливаем новый мок
      allow(ENV).to receive(:[]).with('OPENROUTER_API_KEY').and_return(nil)
      allow(ENV).to receive(:fetch).with('OPENROUTER_API_KEY', nil).and_return(nil)
      
      expect {
        described_class.new(input_file, output_dir)
      }.to raise_error(/Установите переменную OPENROUTER_API_KEY/)
    end
  end

  describe '#process' do
    it 'обрабатывает все задачи' do
      expect(converter).to receive(:process_task).twice
      converter.process
    end

    it 'обрабатывает только указанную задачу, если задан task_number' do
      converter = described_class.new(input_file, output_dir, options.merge(task_number: '0'))
      expect(converter).to receive(:process_task).once
      converter.process
    end
  end

  describe '#process_task' do
    let(:task) { { 'task_id' => 'HumanEval/0', 'prompt' => 'Test prompt' } }

    it 'создает все необходимые файлы' do
      converter.process_task(task)

      expect(File.exist?(File.join(output_dir, 't0.jsonl'))).to be true
      expect(File.exist?(File.join(output_dir, 't0.json'))).to be true
      expect(File.exist?(File.join(output_dir, 't0.md'))).to be true
      expect(File.exist?(File.join(output_dir, 't0-assert.rb'))).to be true
    end

    it 'пропускает существующие файлы, если установлен keep_existing' do
      converter = described_class.new(input_file, output_dir, options.merge(keep_existing: true))
      
      # Создаем существующие файлы
      FileUtils.touch(File.join(output_dir, 't0.jsonl'))
      FileUtils.touch(File.join(output_dir, 't0.json'))
      FileUtils.touch(File.join(output_dir, 't0.md'))
      FileUtils.touch(File.join(output_dir, 't0-assert.rb'))

      expect(converter).not_to receive(:create_task_markdown)
      expect(converter).not_to receive(:create_assertions)

      converter.process_task(task)
    end
  end

  describe '#call_openrouter' do
    it 'отправляет правильный запрос к API' do
      # Сначала очищаем все моки
      WebMock.reset!
      RSpec::Mocks.space.proxy_for(ENV).reset

      # Устанавливаем новые моки для переменных окружения
      allow(ENV).to receive(:[]).with('OPENROUTER_API_KEY').and_return('test_key')
      allow(ENV).to receive(:[]).with('HTTP_REFERER').and_return('https://github.com/yourusername/human-eval-converter')
      allow(ENV).to receive(:[]).with('AI_MODEL').and_return('google/gemini-flash-1.5')
      allow(ENV).to receive(:fetch).with('OPENROUTER_API_KEY', nil).and_return('test_key')
      allow(ENV).to receive(:fetch).with('HTTP_REFERER', 'https://github.com/yourusername/human-eval-converter').and_return('https://github.com/yourusername/human-eval-converter')
      allow(ENV).to receive(:fetch).with('AI_MODEL', 'google/gemini-flash-1.5').and_return('google/gemini-flash-1.5')

      # Устанавливаем новый мок для запроса к API
      stub_request(:post, 'https://openrouter.ai/api/v1/chat/completions')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer test_key',
            'Content-Type' => 'application/json',
            'Host' => 'openrouter.ai',
            'HTTP-Referer' => 'https://github.com/yourusername/human-eval-converter',
            'OpenAI-Organization' => 'openrouter',
            'User-Agent' => 'Human Eval Converter/1.0.0',
            'X-Title' => 'Human Eval Converter'
          },
          body: {
            model: 'google/gemini-flash-1.5',
            messages: [{ role: 'user', content: 'Test prompt' }],
            temperature: 0.1,
            max_tokens: 1000,
            stream: false
          }.to_json
        )
        .to_return(
          status: 200,
          body: {
            choices: [
              {
                message: {
                  content: 'Test response'
                }
              }
            ]
          }.to_json
        )

      converter.send(:call_openrouter, 'Test prompt')

      expect(WebMock).to have_requested(:post, 'https://openrouter.ai/api/v1/chat/completions')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer test_key',
            'Content-Type' => 'application/json',
            'Host' => 'openrouter.ai',
            'HTTP-Referer' => 'https://github.com/yourusername/human-eval-converter',
            'OpenAI-Organization' => 'openrouter',
            'User-Agent' => 'Human Eval Converter/1.0.0',
            'X-Title' => 'Human Eval Converter'
          },
          body: {
            model: 'google/gemini-flash-1.5',
            messages: [{ role: 'user', content: 'Test prompt' }],
            temperature: 0.1,
            max_tokens: 1000,
            stream: false
          }.to_json
        )
    end

    it 'возвращает содержимое ответа от API' do
      response = converter.send(:call_openrouter, 'Test prompt')
      expect(response).to eq('Test response')
    end
  end
end 
