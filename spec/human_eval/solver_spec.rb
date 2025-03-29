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

  describe 'validation' do
    context 'when validating default models' do
      context 'when OPENROUTER_API_KEY is set' do
        before do
          ENV['OPENROUTER_API_KEY'] = 'test_key'
        end

        it 'does not raise error' do
          solver = described_class.new(tasks_dir)
          expect { solver.send(:validate_default_models) }.not_to raise_error
        end
      end

      context 'when OPENROUTER_API_KEY is not set' do
        before do
          ENV['OPENROUTER_API_KEY'] = nil
        end

        it 'raises error when no Ollama models available' do
          solver = described_class.new(tasks_dir)
          allow(solver).to receive(:ollama_models).and_return([])
          expect { solver.send(:validate_default_models) }
            .to raise_error(/Нет доступных локальных моделей Ollama/)
        end

        it 'does not raise error when Ollama models available' do
          solver = described_class.new(tasks_dir)
          allow(solver).to receive(:ollama_models).and_return(['ollama_model'])
          expect { solver.send(:validate_default_models) }.not_to raise_error
        end
      end
    end

    context 'when validating specific model' do
      context 'when model is OpenRouter model' do
        before do
          ENV['OPENROUTER_API_KEY'] = nil
        end

        it 'raises error when OPENROUTER_API_KEY is not set' do
          expect { described_class.new(tasks_dir, model: 'anthropic_claude_3_5_sonnet') }
            .to raise_error(/Установите переменную OPENROUTER_API_KEY/)
        end

        it 'does not raise error when OPENROUTER_API_KEY is set' do
          ENV['OPENROUTER_API_KEY'] = 'test_key'
          expect { described_class.new(tasks_dir, model: 'anthropic_claude_3_5_sonnet') }
            .not_to raise_error
        end
      end

      context 'when model is Ollama model' do
        it 'does not raise error regardless of OPENROUTER_API_KEY' do
          ENV['OPENROUTER_API_KEY'] = nil
          expect { described_class.new(tasks_dir, model: 'ollama_codellama') }
            .not_to raise_error

          ENV['OPENROUTER_API_KEY'] = 'test_key'
          expect { described_class.new(tasks_dir, model: 'ollama_codellama') }
            .not_to raise_error
        end
      end
    end
  end

  describe 'model selection' do
    context 'when specific model is provided' do
      it 'uses only specified model' do
        solver = described_class.new(tasks_dir, model: 'anthropic_claude_3_5_sonnet')
        expect(solver.send(:select_models_for_task)).to eq(['anthropic_claude_3_5_sonnet'])
      end
    end

    context 'when no specific model is provided' do
      context 'when OPENROUTER_API_KEY is set' do
        before do
          ENV['OPENROUTER_API_KEY'] = 'test_key'
        end

        it 'uses all available models' do
          solver = described_class.new(tasks_dir)
          expect(solver.send(:select_models_for_task)).to eq(described_class::MODELS.keys)
        end
      end

      context 'when OPENROUTER_API_KEY is not set' do
        before do
          ENV['OPENROUTER_API_KEY'] = nil
        end

        it 'uses only Ollama models' do
          solver = described_class.new(tasks_dir)
          ollama_models = described_class::MODELS.select { |_, info| info[:provider] == 'ollama' }.keys
          expect(solver.send(:select_models_for_task)).to eq(ollama_models)
        end
      end
    end
  end

  describe 'code extraction' do
    it 'extracts code from ruby blocks' do
      input = <<~INPUT
        Some text
        ```ruby
        def test
          puts "test"
        end
        ```
        More text
      INPUT
      expected = <<~EXPECTED
        def test
          puts "test"
        end
      EXPECTED
      expect(described_class.new(tasks_dir).send(:extract_and_join_code_blocks, input)).to eq(expected)
    end

    it 'extracts code from rb blocks' do
      input = <<~INPUT
        Some text
        ```rb
        def test
          puts "test"
        end
        ```
        More text
      INPUT
      expected = <<~EXPECTED
        def test
          puts "test"
        end
      EXPECTED
      expect(described_class.new(tasks_dir).send(:extract_and_join_code_blocks, input)).to eq(expected)
    end

    it 'returns original text when no code blocks found' do
      input = "Just some text without code blocks"
      expect(described_class.new(tasks_dir).send(:extract_and_join_code_blocks, input)).to eq(input)
    end

    it 'joins multiple code blocks' do
      input = <<~INPUT
        ```ruby
        def test1
          puts "test1"
        end
        ```
        ```ruby
        def test2
          puts "test2"
        end
        ```
      INPUT
      expected = <<~EXPECTED
        def test1
          puts "test1"
        end
        def test2
          puts "test2"
        end
      EXPECTED
      expect(described_class.new(tasks_dir).send(:extract_and_join_code_blocks, input)).to eq(expected)
    end
  end
end
