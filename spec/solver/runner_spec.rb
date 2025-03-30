require 'spec_helper'
require 'webmock/rspec'
require 'tmpdir'
require_relative '../../lib/solver/runner'

RSpec.describe Solver::Runner do
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

  before(:each) do
    FileUtils.mkdir_p(tasks_dir)
    File.write(File.join(tasks_dir, 't1.md'), task_content)
    ENV['OPENROUTER_API_KEY'] = 'test_key'
    WebMock.reset!
    WebMock.disable_net_connect!
  end

  after(:each) do
    FileUtils.rm_rf(tasks_dir)
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
        choices: [
          {
            message: {
              content: <<~SOLUTION
                ```ruby
                def add(a, b)
                  a + b
                end
                ```
              SOLUTION
            }
          }
        ]
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

      # Мокаем File.exist? и File.read для конкретного файла
      solution_file = File.join(tasks_dir, 't1-anthropic_claude_3_5_sonnet.rb')
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?).with(solution_file).and_return(true)
      
      # Мокаем чтение файла задачи и файла решения
      allow(File).to receive(:read).and_call_original
      allow(File).to receive(:read).with(File.join(tasks_dir, 't1.md')).and_return("Задача: Напишите функцию add.")
      allow(File).to receive(:read).with(solution_file).and_return("def add(a, b)\n  a + b\nend\n")
      
      # Мокаем File.write для файла решения
      allow(File).to receive(:write).and_call_original
      allow(File).to receive(:write).with(solution_file, anything).and_return(true)
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
      stub_request(:post, 'http://localhost:11434/api/chat')
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
        
      # Мокаем File.exist? и File.read для конкретного файла
      solution_file = File.join(tasks_dir, 't1-ollama_codellama.rb')
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?).with(solution_file).and_return(true)
      
      # Мокаем чтение файла задачи и файла решения
      allow(File).to receive(:read).and_call_original
      allow(File).to receive(:read).with(File.join(tasks_dir, 't1.md')).and_return("Задача: Напишите функцию add.")
      allow(File).to receive(:read).with(solution_file).and_return("def add(a, b)\n  return a + b\nend\n")
      
      # Мокаем File.write для файла решения
      allow(File).to receive(:write).and_call_original
      allow(File).to receive(:write).with(solution_file, anything).and_return(true)
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

  describe 'error handling' do
    let(:solver) { described_class.new(tasks_dir, model: 'anthropic_claude_3_5_sonnet', create_empty_on_timeout: true) }
    let(:solution_file) { File.join(tasks_dir, 't1-anthropic_claude_3_5_sonnet.rb') }

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
          status: 500,
          body: { error: 'Some API error' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
        
      # Мокаем File.exist? и File.read для конкретного файла
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?).with(solution_file).and_return(true)
      
      # Мокаем чтение файлов
      allow(File).to receive(:read).and_call_original
      allow(File).to receive(:read).with(File.join(tasks_dir, 't1.md')).and_return("Задача: Напишите функцию add.")
      allow(File).to receive(:read).with(solution_file).and_return("# timeout - решение не было получено из-за ошибки\n# Some API error")
      
      # Мокаем запись в файл
      allow(File).to receive(:write).and_call_original
      allow(File).to receive(:write).with(solution_file, anything).and_return(true)
    end

    it 'creates empty file on API error when create_empty_on_timeout is true' do
      solver.process

      solution_file = File.join(tasks_dir, 't1-anthropic_claude_3_5_sonnet.rb')
      expect(File.exist?(solution_file)).to be true

      solution_content = File.read(solution_file)
      expect(solution_content).to include('# timeout - решение не было получено из-за ошибки')
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
          expect(solver.send(:select_models_for_task)).to eq(solver.models.keys)
        end
      end

      context 'when OPENROUTER_API_KEY is not set' do
        before do
          ENV['OPENROUTER_API_KEY'] = nil
        end

        it 'uses only Ollama models' do
          solver = described_class.new(tasks_dir)
          ollama_models = solver.models.select { |_, info| info['provider'] == 'ollama' }.keys
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
      input = 'Just some text without code blocks'
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

  describe '#remove_reasoning_tags' do
    let(:test_tasks_dir) { File.join('spec', 'tmp', 'test_tasks_reasoning') }
    
    before(:each) do
      FileUtils.mkdir_p(test_tasks_dir)
    end
    
    after(:each) do
      FileUtils.rm_rf(test_tasks_dir)
    end
    
    let(:solver) { described_class.new(test_tasks_dir) }
    
    it 'удаляет все содержимое между тегами reasoning' do
      content = <<~CODE
        <reasoning>
        Это рассуждения, которые нужно удалить.
        Много текста с обоснованием решения.
        </reasoning>
        
        def example_method(a, b)
          a + b
        end
      CODE
      
      expected = <<~CODE

        def example_method(a, b)
          a + b
        end
      CODE
      
      result = solver.send(:remove_reasoning_tags, content)
      expect(result).to eq(expected)
    end
    
    it 'не изменяет содержимое без тегов reasoning' do
      content = <<~CODE
        def example_method(a, b)
          a + b
        end
      CODE
      
      expect(solver.send(:remove_reasoning_tags, content)).to eq(content)
    end
    
    it 'корректно обрабатывает несколько блоков reasoning' do
      content = <<~CODE
        <reasoning>
        Первый блок рассуждений.
        </reasoning>
        
        def example_method(a, b)
          <reasoning>
          Второй блок внутри метода.
          </reasoning>
          a + b
        end
      CODE
      
      # Вручную создаем ожидаемый результат
      expected = "\ndef example_method(a, b)\n\n  a + b\nend\n"
      
      result = solver.send(:remove_reasoning_tags, content)
      expect(result).to eq(expected)
    end
  end

  describe '#process_model_response' do
    let(:test_tasks_dir) { File.join('spec', 'tmp', 'test_tasks_process') }
    
    before(:each) do
      FileUtils.mkdir_p(test_tasks_dir)
    end
    
    after(:each) do
      FileUtils.rm_rf(test_tasks_dir)
    end
    
    let(:solver) { described_class.new(test_tasks_dir) }
    
    it 'удаляет теги reasoning из решения перед сохранением' do
      raw_solution = <<~SOLUTION
        ```ruby
        <reasoning>
        Это некоторое рассуждение о решении.
        </reasoning>
        
        def example_method(a, b)
          a + b
        end
        ```
      SOLUTION
      
      output_file = File.join('tmp', 'test_solution.rb')
      FileUtils.mkdir_p(File.dirname(output_file))
      
      # Мокаем метод extract_and_join_code_blocks, чтобы он возвращал содержимое без кавычек
      allow(solver).to receive(:extract_and_join_code_blocks).and_return(
        <<~CODE
          <reasoning>
          Это некоторое рассуждение о решении.
          </reasoning>
          
          def example_method(a, b)
            a + b
          end
        CODE
      )
      
      # Мокаем File.write и File.read
      allow(File).to receive(:write).and_call_original
      allow(File).to receive(:write).with(output_file, anything).and_return(true)
      
      allow(File).to receive(:read).and_call_original
      allow(File).to receive(:read).with(output_file).and_return(
        "def example_method(a, b)\n  a + b\nend\n"
      )
      
      # Вызываем метод process_model_response
      solver.send(:process_model_response, raw_solution, 'test_model', output_file)
      
      # Проверяем, что результат не содержит тега reasoning
      result = File.read(output_file)
      expect(result).not_to include('<reasoning>')
      expect(result).not_to include('</reasoning>')
      expect(result).to include('def example_method(a, b)')
    end
  end
end 