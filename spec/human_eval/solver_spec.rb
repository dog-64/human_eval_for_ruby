# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

RSpec.describe HumanEval::Solver do
  let(:tasks_dir) { 'spec/fixtures/tasks' }
  let(:rules_dir) { 'spec/fixtures/rules' }
  let(:task_content) do
    <<~TASK
      # Напишите функцию, которая складывает два числа
      def add(a, b):
          """
          >>> add(2, 3)
          5
          """
    TASK
  end

  let(:solver_prompt) do
    <<~PROMPT
      - в ответе давай только ruby код, без markdown разметки
      - не повторяй код, если он уже был в ответе
      - не нужно никаких примеров использования кроме текста самой функции
      #{' '}

    PROMPT
  end

  let(:full_prompt) do
    <<~PROMPT
      #{solver_prompt}
      #{task_content}
    PROMPT
  end

  let(:openrouter_model) { 'google/gemini-flash-1.5' }
  let(:ollama_model) { 'ollama/mistral' }

  before(:all) do
    FileUtils.mkdir_p('spec/fixtures/tasks')
    FileUtils.mkdir_p('spec/fixtures/rules')
  end

  after(:all) do
    FileUtils.rm_rf('spec/fixtures')
  end

  before(:each) do
    File.write(File.join(tasks_dir, 't1.md'), task_content)
    File.write(File.join(rules_dir, 'model_solver_prompt.txt'), solver_prompt)
    ENV['OPENROUTER_API_KEY'] = 'test_key'
    ENV['HTTP_REFERER'] = 'https://github.com/yourusername/human-eval-converter'
    WebMock.reset!
    WebMock.disable_net_connect!
    
    # Добавляем отладочную информацию для WebMock
    WebMock.after_request do |request_signature, response|
      puts "\n=== WebMock Debug ==="
      puts "Request Method: #{request_signature.method}"
      puts "Request URI: #{request_signature.uri}"
      puts "Request Headers:"
      request_signature.headers.each do |key, value|
        puts "  #{key}: #{value}"
      end
      puts "Request Body: #{request_signature.body}"
      puts "Response Status: #{response.status}"
      puts "Response Body: #{response.body}"
      puts "=== End WebMock Debug ===\n"
    end
  end

  describe 'initialization' do
    it 'initializes without error' do
      expect { described_class.new(tasks_dir) }.not_to raise_error
    end
  end

  describe 'OpenRouter.ai model' do
    let(:solver) { described_class.new(tasks_dir, model: openrouter_model, log_level: 'none', rules_dir: rules_dir) }
    let(:solution) do
      <<~SOLUTION
        def add(a, b)
          a + b
        end
      SOLUTION
    end

    before do
      stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => "Bearer #{ENV['OPENROUTER_API_KEY']}",
            'Content-Type' => 'application/json',
            'Host' => 'openrouter.ai',
            'Http-Referer' => ENV['HTTP_REFERER'],
            'Openai-Organization' => 'openrouter',
            'User-Agent' => 'Human Eval Converter/1.0.0',
            'X-Title' => 'Human Eval Converter'
          }
        )
        .with do |req|
          body = JSON.parse(req.body)
          body['model'] == openrouter_model &&
          body['messages'].is_a?(Array) &&
          body['messages'].size == 1 &&
          body['messages'][0]['role'] == 'user' &&
          body['temperature'] == 0.1 &&
          body['max_tokens'] == 32000 &&
          body['stream'] == false
        end
        .to_return(status: 200, body: { choices: [{ message: { content: solution } }] }.to_json)
    end

    it 'processes task with OpenRouter model successfully' do
      expect { solver.process }.not_to raise_error
    end
  end

  describe 'Ollama model' do
    let(:solver) { described_class.new(tasks_dir, model: ollama_model, log_level: 'none', rules_dir: rules_dir) }
    let(:solution) do
      <<~SOLUTION
        def add(a, b)
          return a + b
        end
      SOLUTION
    end

    before do
      stub_request(:post, "http://localhost:11434/api/chat")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'Host' => 'localhost:11434'
          }
        )
        .with do |req|
          body = JSON.parse(req.body)
          body['model'] == ollama_model.sub('ollama/', '') &&
          body['messages'].is_a?(Array) &&
          body['messages'].size == 1 &&
          body['messages'][0]['role'] == 'user' &&
          body['options']['temperature'] == 0.1 &&
          body['options']['num_predict'] == 4096 &&
          body['stream'] == false
        end
        .to_return(status: 200, body: { response: solution }.to_json)
    end

    it 'processes task with Ollama model successfully' do
      expect { solver.process }.not_to raise_error
    end
  end

  describe 'Error handling' do
    let(:solver) { described_class.new(tasks_dir, model: openrouter_model, log_level: 'none', rules_dir: rules_dir) }

    context 'when API returns an error' do
      it 'handles API errors gracefully' do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => "Bearer #{ENV['OPENROUTER_API_KEY']}",
              'Content-Type' => 'application/json',
              'Host' => 'openrouter.ai',
              'Http-Referer' => ENV['HTTP_REFERER'],
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Converter/1.0.0',
              'X-Title' => 'Human Eval Converter'
            }
          )
          .with do |req|
            body = JSON.parse(req.body)
            body['model'] == openrouter_model &&
            body['messages'].is_a?(Array) &&
            body['messages'].size == 1 &&
            body['messages'][0]['role'] == 'user' &&
            body['temperature'] == 0.1 &&
            body['max_tokens'] == 32000 &&
            body['stream'] == false
          end
          .to_return(status: 500, body: { error: 'Internal Server Error' }.to_json)

        expect do
          solver.process
        end.to raise_error(RuntimeError, %r{Ошибка API при вызове модели #{openrouter_model}})
      end
    end

    context 'when API returns empty response' do
      it 'handles empty responses gracefully' do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => "Bearer #{ENV['OPENROUTER_API_KEY']}",
              'Content-Type' => 'application/json',
              'Host' => 'openrouter.ai',
              'Http-Referer' => ENV['HTTP_REFERER'],
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Converter/1.0.0',
              'X-Title' => 'Human Eval Converter'
            }
          )
          .with do |req|
            body = JSON.parse(req.body)
            body['model'] == openrouter_model &&
            body['messages'].is_a?(Array) &&
            body['messages'].size == 1 &&
            body['messages'][0]['role'] == 'user' &&
            body['temperature'] == 0.1 &&
            body['max_tokens'] == 32000 &&
            body['stream'] == false
          end
          .to_return(status: 200, body: { choices: [{ message: { content: '' } }] }.to_json)

        expect { solver.process }.to raise_error(RuntimeError, 'Пустой ответ от API')
      end
    end
  end
end
