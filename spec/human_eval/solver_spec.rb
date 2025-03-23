# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

RSpec.describe HumanEval::Solver do
  let(:tasks_dir) { 'spec/fixtures/tasks' }
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

  let(:openrouter_model) { 'anthropic/claude-3.5-sonnet' }
  let(:ollama_model) { 'codellama' }

  before(:all) do
    FileUtils.mkdir_p('spec/fixtures/tasks')
  end

  after(:all) do
    FileUtils.rm_rf('spec/fixtures/tasks')
  end

  before(:each) do
    File.write(File.join(tasks_dir, 't1.md'), task_content)
    ENV['OPENROUTER_API_KEY'] = 'test_key'
    WebMock.reset!
    WebMock.disable_net_connect!
  end

  describe 'initialization' do
    it 'initializes without error' do
      expect { described_class.new(tasks_dir) }.not_to raise_error
    end
  end

  describe 'OpenRouter.ai model' do
    let(:solver) { described_class.new(tasks_dir, model: openrouter_model, log_level: 'none') }
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
            'Authorization' => "Bearer #{ENV['OPENROUTER_API_KEY']}",
            'Content-Type' => 'application/json',
            'Http-Referer' => 'https://github.com/yourusername/human-eval-solver',
            'X-Title' => 'Human Eval Solver',
            'Openai-Organization' => 'openrouter',
            'User-Agent' => 'Human Eval Solver/1.0.0'
          },
          body: hash_including(
            'model' => openrouter_model,
            'messages' => array_including(
              hash_including('content' => /Add two numbers/)
            ),
            'temperature' => 0.7,
            'max_tokens' => 1000,
            'stream' => false
          )
        )
        .to_return(status: 200, body: { choices: [{ message: { content: solution } }] }.to_json)
    end

    it 'processes task with OpenRouter model successfully' do
      expect { solver.process }.not_to raise_error
    end
  end

  describe 'Ollama model' do
    let(:solver) { described_class.new(tasks_dir, model: ollama_model, log_level: 'none') }
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
            'Content-Type' => 'application/json',
            'Host' => 'localhost:11434',
            'User-Agent' => 'Human Eval Solver/1.0.0'
          },
          body: hash_including(
            'model' => ollama_model,
            'messages' => array_including(
              hash_including('content' => /Add two numbers/)
            ),
            'options' => {
              'temperature' => 0.7,
              'num_predict' => 4096
            },
            'stream' => false
          )
        )
        .to_return(status: 200, body: { response: solution }.to_json)
    end

    it 'processes task with Ollama model successfully' do
      expect { solver.process }.not_to raise_error
    end
  end

  describe 'Error handling' do
    let(:solver) { described_class.new(tasks_dir, model: openrouter_model, log_level: 'none') }

    context 'when API returns an error' do
      it 'handles API errors gracefully' do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .with(
            headers: { 
              'Authorization' => "Bearer #{ENV['OPENROUTER_API_KEY']}",
              'Content-Type' => 'application/json',
              'Http-Referer' => 'https://github.com/yourusername/human-eval-solver',
              'X-Title' => 'Human Eval Solver',
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Solver/1.0.0'
            },
            body: hash_including(
              'model' => openrouter_model,
              'messages' => array_including(
                hash_including('content' => /Add two numbers/)
              ),
              'temperature' => 0.7,
              'max_tokens' => 1000,
              'stream' => false
            )
          )
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
              'Authorization' => "Bearer #{ENV['OPENROUTER_API_KEY']}",
              'Content-Type' => 'application/json',
              'Http-Referer' => 'https://github.com/yourusername/human-eval-solver',
              'X-Title' => 'Human Eval Solver',
              'Openai-Organization' => 'openrouter',
              'User-Agent' => 'Human Eval Solver/1.0.0'
            },
            body: hash_including(
              'model' => openrouter_model,
              'messages' => array_including(
                hash_including('content' => /Add two numbers/)
              ),
              'temperature' => 0.7,
              'max_tokens' => 1000,
              'stream' => false
            )
          )
          .to_return(status: 200, body: { choices: [{ message: { content: '' } }] }.to_json)

        expect { solver.process }.to raise_error(RuntimeError, 'Пустой ответ от API')
      end
    end
  end
end
