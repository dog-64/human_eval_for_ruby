require 'spec_helper'
require 'fileutils'
require_relative '../lib/test_runner'

RSpec.describe TestRunner::Runner do
  let(:tasks_dir) { 'tasks' }
  let(:runner) { described_class.new(log_level: 'none') }
  let(:solution1_content) { "def add(a, b)\n  a + b\nend" }
  let(:solution2_content) { "def add(a, b)\n  a - b\nend" } # Неправильное решение
  let(:test_content) do
    <<~RUBY
      assert_equal(add(2, 3), 5)
      assert_equal(add(-1, 1), 0)
      assert_equal(add(0, 0), 0)
    RUBY
  end

  before(:each) do
    FileUtils.mkdir_p(tasks_dir)
    FileUtils.rm_rf(Dir.glob(File.join(tasks_dir, '*')))

    # Создаем тестовые файлы
    File.write(File.join(tasks_dir, 't1-model1.rb'), solution1_content)
    File.write(File.join(tasks_dir, 't1-model2.rb'), solution2_content)
    File.write(File.join(tasks_dir, 't1-assert.rb'), test_content)
    
    # Подменяем метод find_solution_files для тестов
    allow(runner).to receive(:find_solution_files).with(no_args).and_return([
      'tasks/t1-model1.rb',
      'tasks/t1-model2.rb'
    ])
    allow(runner).to receive(:find_solution_files).with('t1').and_return([
      'tasks/t1-model1.rb',
      'tasks/t1-model2.rb'
    ])
  end

  after(:each) do
    FileUtils.rm_rf(tasks_dir)
  end

  describe '#run_all_tests' do
    it 'runs tests only for mock solutions' do
      results = runner.run_all_tests

      expect(results['t1'].keys).to contain_exactly('model1', 'model2')
      expect(results['t1']['model1']).to be true   # Правильное решение
      expect(results['t1']['model2']).to be false  # Неправильное решение
    end
  end

  describe '#run_task_tests' do
    it 'runs tests only for mock solutions of specific task' do
      results = runner.run_task_tests('t1')

      expect(results['t1'].keys).to contain_exactly('model1', 'model2')
      expect(results['t1']['model1']).to be true   # Правильное решение
      expect(results['t1']['model2']).to be false  # Неправильное решение
    end
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

  describe '#run_model_tests' do
    it 'runs test only for specified model' do
      results = runner.run_model_tests('t1', 'model1')
      
      expect(results).to be_a(Hash)
      expect(results['t1'].keys).to contain_exactly('model1')
      expect(results['t1']['model1']).to be true
    end

    it 'runs tests for model2 and detects failure' do
      results = runner.run_model_tests('t1', 'model2')
      
      expect(results).to be_a(Hash)
      expect(results['t1'].keys).to contain_exactly('model2')
      expect(results['t1']['model2']).to be false
    end

    it 'handles missing solution file' do
      results = runner.run_model_tests('t1', 'nonexistent_model')
      expect(results).to be_a(Hash)
      expect(results).to eq({})
    end
  end

  describe 'test execution' do
    context 'with syntax error in solution' do
      before do
        invalid_solution = <<~SOLUTION
          def add(a, b)
            a + b # Отсутствует end
        SOLUTION
        File.write(File.join(tasks_dir, 't1-model1.rb'), invalid_solution)
      end

      it 'handles syntax errors gracefully' do
        results = runner.run_model_tests('t1', 'model1')
        
        expect(results).to be_a(Hash)
        expect(results['t1']['model1']).to be false
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
        File.write(File.join(tasks_dir, 't1-model1.rb'), infinite_loop_solution)
      end

      it 'handles timeouts gracefully' do
        results = runner.run_model_tests('t1', 'model1')
        
        expect(results).to be_a(Hash)
        expect(results['t1']['model1']).to be false
      end
    end
  end
end 