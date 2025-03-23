# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

RSpec.describe HumanEvalConverter do
  let(:input_file) { 'spec/fixtures/test.jsonl' }
  let(:output_dir) { 'output' }
  let(:api_key) { 'test_key' }
  let(:converter) { described_class.new(input_file, output_dir, log_level: 'none') }
  
  let(:task1_data) do
    {
      'task_id' => 'HumanEval/1',
      'prompt' => 'def add(a, b):\n    """Add two numbers"""\n',
      'entry_point' => 'add',
      'test' => 'assert add(2, 3) == 5'
    }
  end
  
  let(:task2_data) do
    {
      'task_id' => 'HumanEval/2',
      'prompt' => 'def multiply(a, b):\n    """Multiply two numbers"""\n',
      'entry_point' => 'multiply',
      'test' => 'assert multiply(2, 3) == 6'
    }
  end

  let(:llm_response_description1) { "Функция add принимает два числа и возвращает их сумму" }
  let(:llm_response_description2) { "Функция multiply принимает два числа и возвращает их произведение" }
  
  let(:llm_response_tests1) { "assert_equal(add(2, 3), 5)\nassert_equal(add(-1, 1), 0)" }
  let(:llm_response_tests2) { "assert_equal(multiply(2, 3), 6)\nassert_equal(multiply(-2, 3), -6)" }

  before do
    # Устанавливаем API ключ
    ENV['OPENROUTER_API_KEY'] = api_key
    stub_const("#{described_class}::OPENROUTER_API_KEY", api_key)

    # Мокаем чтение файлов
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:read).with(input_file).and_return("#{task1_data.to_json}\n#{task2_data.to_json}")
    allow(File).to receive(:read).with('rules/description_prompt.txt').and_return('Опиши задачу')
    allow(File).to receive(:read).with('rules/test_prompt.txt').and_return('Создай тесты')
    
    # Мокаем запись файлов
    allow(File).to receive(:write).with(any_args).and_return(true)
    allow(FileUtils).to receive(:mkdir_p).with(any_args)
    
    # Мокаем API ответы для описаний
    stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
      .with(
        headers: { 
          'Authorization' => "Bearer #{api_key}",
          'Content-Type' => 'application/json',
          'Http-Referer' => 'https://github.com/yourusername/human-eval-converter',
          'X-Title' => 'Human Eval Converter',
          'Openai-Organization' => 'openrouter',
          'User-Agent' => 'Human Eval Converter/1.0.0'
        },
        body: hash_including(
          'model' => 'anthropic/claude-3-sonnet-20240229',
          'messages' => array_including(
            hash_including('content' => /Add two numbers/)
          ),
          'temperature' => 0.7,
          'max_tokens' => 1000,
          'stream' => false
        )
      )
      .to_return(status: 200, body: { choices: [{ message: { content: llm_response_description1 } }] }.to_json)

    stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
      .with(
        headers: { 
          'Authorization' => "Bearer #{api_key}",
          'Content-Type' => 'application/json',
          'HTTP-Referer' => 'https://github.com/yourusername/human-eval-converter',
          'X-Title' => 'Human Eval Converter',
          'OpenAI-Organization' => 'openrouter',
          'User-Agent' => 'Human Eval Converter/1.0.0'
        },
        body: hash_including(
          'model' => 'anthropic/claude-3-sonnet-20240229',
          'messages' => array_including(
            hash_including('content' => /Multiply two numbers/)
          ),
          'temperature' => 0.7,
          'max_tokens' => 1000,
          'stream' => false
        )
      )
      .to_return(status: 200, body: { choices: [{ message: { content: llm_response_description2 } }] }.to_json)

    # Мокаем API ответы для тестов
    stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
      .with(
        headers: { 
          'Authorization' => "Bearer #{api_key}",
          'Content-Type' => 'application/json',
          'HTTP-Referer' => 'https://github.com/yourusername/human-eval-converter',
          'X-Title' => 'Human Eval Converter',
          'OpenAI-Organization' => 'openrouter',
          'User-Agent' => 'Human Eval Converter/1.0.0'
        },
        body: hash_including(
          'model' => 'anthropic/claude-3-sonnet-20240229',
          'messages' => array_including(
            hash_including('content' => /#{llm_response_description1}/)
          ),
          'temperature' => 0.7,
          'max_tokens' => 1000,
          'stream' => false
        )
      )
      .to_return(status: 200, body: { choices: [{ message: { content: llm_response_tests1 } }] }.to_json)

    stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
      .with(
        headers: { 
          'Authorization' => "Bearer #{api_key}",
          'Content-Type' => 'application/json',
          'HTTP-Referer' => 'https://github.com/yourusername/human-eval-converter',
          'X-Title' => 'Human Eval Converter',
          'OpenAI-Organization' => 'openrouter',
          'User-Agent' => 'Human Eval Converter/1.0.0'
        },
        body: hash_including(
          'model' => 'anthropic/claude-3-sonnet-20240229',
          'messages' => array_including(
            hash_including('content' => /#{llm_response_description2}/)
          ),
          'temperature' => 0.7,
          'max_tokens' => 1000,
          'stream' => false
        )
      )
      .to_return(status: 200, body: { choices: [{ message: { content: llm_response_tests2 } }] }.to_json)
  end

  describe '#process' do
    context 'when processing all tasks' do
      it 'processes both tasks' do
        expect(FileUtils).to receive(:mkdir_p).with(output_dir)
        
        # Проверяем сохранение файлов для задачи 1
        expect(File).to receive(:write).with("#{output_dir}/t1.jsonl", task1_data.to_json)
        expect(File).to receive(:write).with("#{output_dir}/t1.json", JSON.pretty_generate(task1_data))
        expect(File).to receive(:write).with("#{output_dir}/t1.md", /#{llm_response_description1}/)
        expect(File).to receive(:write).with("#{output_dir}/t1-assert.rb", llm_response_tests1)
        
        # Проверяем сохранение файлов для задачи 2
        expect(File).to receive(:write).with("#{output_dir}/t2.jsonl", task2_data.to_json)
        expect(File).to receive(:write).with("#{output_dir}/t2.json", JSON.pretty_generate(task2_data))
        expect(File).to receive(:write).with("#{output_dir}/t2.md", /#{llm_response_description2}/)
        expect(File).to receive(:write).with("#{output_dir}/t2-assert.rb", llm_response_tests2)

        converter.process
      end
    end

    context 'when processing specific task' do
      let(:converter) { described_class.new(input_file, output_dir, task_number: '1', log_level: 'none') }

      it 'processes only specified task' do
        expect(FileUtils).to receive(:mkdir_p).with(output_dir)
        
        # Проверяем сохранение файлов только для задачи 1
        expect(File).to receive(:write).with("#{output_dir}/t1.jsonl", task1_data.to_json)
        expect(File).to receive(:write).with("#{output_dir}/t1.json", JSON.pretty_generate(task1_data))
        expect(File).to receive(:write).with("#{output_dir}/t1.md", /#{llm_response_description1}/)
        expect(File).to receive(:write).with("#{output_dir}/t1-assert.rb", llm_response_tests1)
        
        # Проверяем что файлы задачи 2 не создаются
        expect(File).not_to receive(:write).with("#{output_dir}/t2.jsonl", anything)
        expect(File).not_to receive(:write).with("#{output_dir}/t2.json", anything)
        expect(File).not_to receive(:write).with("#{output_dir}/t2.md", anything)
        expect(File).not_to receive(:write).with("#{output_dir}/t2-assert.rb", anything)

        converter.process
      end
    end
  end

  describe '#initialize' do
    context 'with invalid input file' do
      before do
        allow(File).to receive(:exist?).with(input_file).and_return(false)
      end

      it 'raises error' do
        expect { described_class.new(input_file, output_dir) }.to raise_error(/не найден/)
      end
    end

    context 'without API key' do
      before do
        stub_const("#{described_class}::OPENROUTER_API_KEY", nil)
        ENV['OPENROUTER_API_KEY'] = nil
      end

      it 'raises error' do
        expect { described_class.new(input_file, output_dir) }.to raise_error(/OPENROUTER_API_KEY/)
      end
    end
  end

  describe 'error handling' do
    context 'when API returns error' do
      before do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .with(
            headers: { 
              'Authorization' => "Bearer #{api_key}",
              'Content-Type' => 'application/json',
              'Http-Referer' => 'https://github.com/yourusername/human-eval-converter',
              'X-Title' => 'Human Eval Converter',
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Converter/1.0.0'
            },
            body: hash_including(
              'model' => 'anthropic/claude-3-sonnet-20240229',
              'messages' => array_including(
                hash_including('content' => /Add two numbers/)
              ),
              'temperature' => 0.7,
              'max_tokens' => 1000,
              'stream' => false
            )
          )
          .to_return(status: 500, body: { error: 'Internal Server Error' }.to_json)
      end

      it 'handles API errors gracefully' do
        expect { converter.process }.to raise_error(RuntimeError, /Ошибка API/)
      end
    end

    context 'when API returns empty response' do
      before do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .with(
            headers: { 
              'Authorization' => "Bearer #{api_key}",
              'Content-Type' => 'application/json',
              'Http-Referer' => 'https://github.com/yourusername/human-eval-converter',
              'X-Title' => 'Human Eval Converter',
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Converter/1.0.0'
            },
            body: hash_including(
              'model' => 'anthropic/claude-3-sonnet-20240229',
              'messages' => array_including(
                hash_including('content' => /Add two numbers/)
              ),
              'temperature' => 0.7,
              'max_tokens' => 1000,
              'stream' => false
            )
          )
          .to_return(status: 200, body: { choices: [{ message: { content: '' } }] }.to_json)
      end

      it 'handles empty responses gracefully' do
        expect { converter.process }.to raise_error(RuntimeError, /Пустой ответ от API/)
      end
    end
  end
end 