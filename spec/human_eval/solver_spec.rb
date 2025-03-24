# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'
require 'tmpdir'

RSpec.describe HumanEval::SolverClass do
  let(:tasks_dir) { File.join('spec', 'tmp', 'test_tasks') }
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

  before(:all) do
    # Ничего не делаем в before(:all), так как каждый тест будет использовать свою временную директорию
  end

  after(:all) do
    # Ничего не делаем в after(:all), так как каждый тест сам очистит свою временную директорию
  end

  before(:each) do
    FileUtils.mkdir_p(tasks_dir)
    File.write(File.join(tasks_dir, 't1.md'), task_content)
    ENV['OPENROUTER_API_KEY'] = 'test_key'
    WebMock.reset!
    WebMock.disable_net_connect!
  end

  after(:each) do
    FileUtils.rm_rf(tasks_dir) if Dir.exist?(tasks_dir)
  end

  describe 'initialization' do
    it 'initializes without error' do
      expect { described_class.new(tasks_dir) }.not_to raise_error
    end
  end

  describe 'OpenRouter.ai model' do
    let(:solver) { described_class.new(tasks_dir, model: 'anthropic_claude_3_5_sonnet') }
    let(:openrouter_response) do
      {
        choices: [{
          message: {
            content: <<~SOLUTION
              ```ruby
              def add(a, b)
                a + b
              end
              ```
            SOLUTION
          }
        }]
      }
    end

    before do
      stub_request(:post, 'https://openrouter.ai/api/v1/chat/completions')
        .with(
          headers: {
            'Authorization' => 'Bearer test_key',
            'Content-Type' => 'application/json',
            'HTTP-Referer' => 'https://github.com/yourusername/human-eval-solver',
            'X-Title' => 'Human Eval Solver'
          }
        )
        .to_return(
          status: 200,
          body: openrouter_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'processes task with OpenRouter model successfully' do
      solver.process

      solution_file = File.join(tasks_dir, 't1-anthropic_claude_3_5_sonnet.rb')
      expect(File.exist?(solution_file)).to be true

      solution_content = File.read(solution_file)
      expect(solution_content).to include('def add(a, b)')
      expect(solution_content).to include('a + b')
    end
  end

  describe 'Ollama model' do
    let(:solver) { described_class.new(tasks_dir, model: 'ollama_codellama') }
    let(:ollama_response) do
      {
        message: {
          content: <<~SOLUTION
            ```ruby
            def add(a, b)
              return a + b
            end
            ```
          SOLUTION
        }
      }
    end

    before do
      stub_request(:post, "http://localhost:11434/api/chat")
        .with(
          headers: {
            'Content-Type' => 'application/json'
          }
        )
        .to_return(
          status: 200,
          body: ollama_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'processes task with Ollama model successfully' do
      solver.process

      solution_file = File.join(tasks_dir, 't1-ollama_codellama.rb')
      expect(File.exist?(solution_file)).to be true

      solution_content = File.read(solution_file)
      expect(solution_content).to include('def add(a, b)')
      expect(solution_content).to include('return a + b')
    end
  end

  describe 'Error handling' do
    let(:solver) { described_class.new(tasks_dir, model: 'anthropic_claude_3_5_sonnet') }

    context 'when API returns an error' do
      before do
        stub_request(:post, 'https://openrouter.ai/api/v1/chat/completions')
          .with(
            headers: {
              'Authorization' => 'Bearer test_key',
              'Content-Type' => 'application/json',
              'HTTP-Referer' => 'https://github.com/yourusername/human-eval-solver',
              'X-Title' => 'Human Eval Solver'
            }
          )
          .to_return(status: 500, body: 'Internal Server Error')
      end

      it 'handles API errors gracefully' do
        expect do
          solver.process
        end.to raise_error(RuntimeError, %r{Ошибка API при вызове модели anthropic/claude-3\.5-sonnet})
      end
    end

    context 'when API returns empty response' do
      before do
        stub_request(:post, 'https://openrouter.ai/api/v1/chat/completions')
          .with(
            headers: {
              'Authorization' => 'Bearer test_key',
              'Content-Type' => 'application/json',
              'HTTP-Referer' => 'https://github.com/yourusername/human-eval-solver',
              'X-Title' => 'Human Eval Solver'
            }
          )
          .to_return(
            status: 200,
            body: { choices: [{ message: { content: '' } }] }.to_json
          )
      end

      it 'handles empty responses gracefully' do
        expect { solver.process }.to raise_error(RuntimeError, 'Пустой ответ от API')
      end
    end
  end
end
