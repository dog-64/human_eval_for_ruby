# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

RSpec.describe HumanEval::SolverClass do
  let(:tasks_dir) { 'spec/fixtures/tasks' }
  let(:rules_dir) { 'rules' }
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

  let(:openrouter_model) { 'google_gemini_flash_1_5' }
  let(:ollama_model) { 'ollama_codellama' }

  before(:all) do
    FileUtils.mkdir_p('spec/fixtures/tasks')
  end

  after(:all) do
    FileUtils.rm_rf('spec/fixtures')
  end

  before(:each) do
    File.write(File.join(tasks_dir, 't1.md'), task_content)
    File.write(File.join(rules_dir, 'model_solver_prompt.txt'), solver_prompt)
    ENV['OPENROUTER_API_KEY'] = 'test_openrouter_api_key'
    ENV['HTTP_REFERER'] = 'https://github.com/yourusername/human-eval-solver'
    WebMock.reset!
    WebMock.disable_net_connect!
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

    it 'processes task with OpenRouter model successfully' do
      # Стаб для OpenRouter API
      stub_request(:post, 'https://openrouter.ai/api/v1/chat/completions')
        .with(
          body: {
            model: 'google/gemini-flash-1.5',
            messages: [{ role: 'user', content: full_prompt }],
            temperature: 0.1,
            max_tokens: 32_000,
            stream: false
          }.to_json,
          headers: {
            'Authorization' => 'Bearer test_openrouter_api_key',
            'Content-Type' => 'application/json',
            'HTTP-Referer' => 'https://github.com/yourusername/human-eval-solver',
            'X-Title' => 'Human Eval Solver'
          }
        )
        .to_return(
          status: 200,
          body: {
            choices: [
              {
                message: {
                  content: "def solution(x):\n  return x + 1"
                }
              }
            ]
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

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

    it 'processes task with Ollama model successfully' do
      # Стаб для Ollama API
      stub_request(:post, 'http://localhost:11434/api/chat')
        .with(
          body: {
            model: 'codellama',
            messages: [{ role: 'user', content: full_prompt }],
            stream: false,
            options: {
              temperature: 0.1,
              num_predict: 4096
            }
          }.to_json,
          headers: {
            'Content-Type' => 'application/json'
          }
        )
        .to_return(
          status: 200,
          body: {
            message: {
              content: "def solution(x):\n  return x + 1"
            }
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      expect { solver.process }.not_to raise_error
    end
  end

  describe 'Error handling' do
    let(:solver) { described_class.new(tasks_dir, model: openrouter_model, log_level: 'none', rules_dir: rules_dir) }

    context 'when API returns an error' do
      before do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .to_return(status: 500, body: { error: 'Internal Server Error' }.to_json)
      end

      it 'handles API errors gracefully' do
        expect { solver.process }.to raise_error(RuntimeError, /Ошибка API/)
      end
    end

    context 'when API returns empty response' do
      before do
        stub_request(:post, "https://openrouter.ai/api/v1/chat/completions")
          .to_return(status: 200, body: { choices: [{ message: { content: '' } }] }.to_json)
      end

      it 'handles empty responses gracefully' do
        expect { solver.process }.to raise_error(RuntimeError, /Пустой ответ/)
      end
    end

    context 'when tasks directory does not exist' do
      let(:solver) { described_class.new('nonexistent_dir', model: openrouter_model, log_level: 'none', rules_dir: rules_dir) }

      it 'raises an error' do
        expect { solver.process }.to raise_error(RuntimeError, /не найден/)
      end
    end

    context 'without API key for OpenRouter.ai model' do
      before { ENV['OPENROUTER_API_KEY'] = nil }
      let(:solver) { described_class.new(tasks_dir, model: openrouter_model, log_level: 'none', rules_dir: rules_dir) }

      it 'raises an error' do
        expect { solver.process }.to raise_error(RuntimeError, /OPENROUTER_API_KEY/)
      end
    end
  end
end

