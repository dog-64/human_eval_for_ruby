require 'spec_helper'
require 'fileutils'
require_relative '../lib/test_runner'

RSpec.describe TestRunner::Runner do
  let(:tasks_dir) { 'spec/fixtures/tasks' }
  let(:solution_content) do
    <<~SOLUTION
      def add(a, b)
        a + b
      end
    SOLUTION
  end

  let(:test_content) do
    <<~TEST
      assert add(2, 3) == 5
      assert add(-1, 1) == 0
      assert add(0, 0) == 0
    TEST
  end

  before(:all) do
    FileUtils.mkdir_p('spec/fixtures/tasks')
  end

  after(:all) do
    FileUtils.rm_rf('spec/fixtures/tasks')
  end

  before(:each) do
    # Создаем тестовые файлы перед каждым тестом
    File.write(File.join(tasks_dir, 't1-test_model.rb'), solution_content)
    File.write(File.join(tasks_dir, 't1-assert.rb'), test_content)
  end

  describe 'initialization' do
    it 'initializes without error' do
      expect { described_class.new }.not_to raise_error
    end

    it 'accepts options' do
      runner = described_class.new(log_level: :debug)
      expect(runner.instance_variable_get(:@options)[:log_level]).to eq(:debug)
    end

    it 'sets default timeout' do
      runner = described_class.new
      expect(runner.instance_variable_get(:@timeout)).to eq(5)
    end
  end

  describe '#run_all_tests' do
    let(:runner) { described_class.new }

    it 'runs tests successfully' do
      results = runner.run_all_tests
      expect(results).to be_a(Hash)
      expect(results['t1']['test_model']).to be true
    end

    it 'handles missing solution files' do
      FileUtils.rm_f(File.join(tasks_dir, 't1-test_model.rb'))
      results = runner.run_all_tests
      expect(results).to be_a(Hash)
      expect(results['t1']).to be_a(Hash)
    end

    it 'handles empty solution files' do
      File.write(File.join(tasks_dir, 't1-test_model.rb'), '')
      results = runner.run_all_tests
      expect(results).to be_a(Hash)
      expect(results['t1']['test_model']).to be false
    end
  end

  describe '#run_task_tests' do
    let(:runner) { described_class.new }

    it 'runs tests for specific task' do
      results = runner.run_task_tests('t1')
      expect(results).to be_a(Hash)
      expect(results['t1']['test_model']).to be true
    end

    it 'handles invalid task format' do
      results = runner.run_task_tests('invalid')
      expect(results).to be_a(Hash)
      expect(results['invalid']).to be_nil
    end

    it 'handles missing test file' do
      FileUtils.rm_f(File.join(tasks_dir, 't1-assert.rb'))
      results = runner.run_task_tests('t1')
      expect(results).to be_a(Hash)
      expect(results['t1']).to be_a(Hash)
    end
  end

  describe '#run_model_tests' do
    let(:runner) { described_class.new }

    it 'runs tests for specific model' do
      results = runner.run_model_tests('t1', 'test_model')
      expect(results).to be_a(Hash)
      expect(results['t1']['test_model']).to be true
    end

    it 'handles missing solution file' do
      results = runner.run_model_tests('t1', 'nonexistent_model')
      expect(results).to be_a(Hash)
      expect(results['t1']['nonexistent_model']).to be false
    end

    it 'handles invalid model name' do
      results = runner.run_model_tests('t1', 'invalid/model')
      expect(results).to be_a(Hash)
      expect(results['t1']['invalid/model']).to be false
    end
  end

  describe 'test execution' do
    let(:runner) { described_class.new }

    context 'with valid solution' do
      it 'passes all tests' do
        results = runner.run_model_tests('t1', 'test_model')
        expect(results).to be_a(Hash)
        expect(results['t1']['test_model']).to be true
      end
    end

    context 'with failing solution' do
      before do
        failing_solution = <<~SOLUTION
          def add(a, b)
            a - b # Неправильная реализация
          end
        SOLUTION
        File.write(File.join(tasks_dir, 't1-test_model.rb'), failing_solution)
      end

      it 'reports test failures' do
        results = runner.run_model_tests('t1', 'test_model')
        expect(results).to be_a(Hash)
        expect(results['t1']['test_model']).to be false
      end
    end

    context 'with syntax error in solution' do
      before do
        invalid_solution = <<~SOLUTION
          def add(a, b)
            a + b # Отсутствует end
        SOLUTION
        File.write(File.join(tasks_dir, 't1-test_model.rb'), invalid_solution)
      end

      it 'handles syntax errors gracefully' do
        results = runner.run_model_tests('t1', 'test_model')
        expect(results).to be_a(Hash)
        expect(results['t1']['test_model']).to be false
      end
    end
  end

  describe 'timeout handling' do
    let(:runner) { described_class.new(timeout: 1) }

    context 'with infinite loop in solution' do
      before do
        infinite_loop_solution = <<~SOLUTION
          def add(a, b)
            while true; end
            a + b
          end
        SOLUTION
        File.write(File.join(tasks_dir, 't1-test_model.rb'), infinite_loop_solution)
      end

      it 'handles timeouts gracefully' do
        results = runner.run_model_tests('t1', 'test_model')
        expect(results).to be_a(Hash)
        expect(results['t1']['test_model']).to be false
      end
    end
  end
end 