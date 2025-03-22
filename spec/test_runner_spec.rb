# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'
require_relative '../lib/test_runner'

RSpec.describe TestRunner::Runner do
  let(:runner) { described_class.new(log_level: 'none') }
  let(:solution1_content) { "def add(a, b)\n  a + b\nend" }
  let(:solution2_content) { "def add(a, b)\n  a - b\nend" }
  let(:test_content) { "assert_equal(add(2, 3), 5)" }

  before(:each) do
    # Подменяем чтение файлов
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:exist?).with('tasks/t1-assert.rb').and_return(true)
    allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return(solution1_content)
    allow(File).to receive(:read).with('tasks/t1-model2.rb').and_return(solution2_content)
    allow(File).to receive(:read).with('tasks/t1-assert.rb').and_return(test_content)
    
    # Подменяем поиск файлов
    allow(runner).to receive(:find_solution_files).with(no_args).and_return([
      'tasks/t1-model1.rb',
      'tasks/t1-model2.rb'
    ])
    allow(runner).to receive(:find_solution_files).with('t1').and_return([
      'tasks/t1-model1.rb',
      'tasks/t1-model2.rb'
    ])

    # Подменяем Dir.glob для run_model_tests
    allow(Dir).to receive(:glob).with('tasks/t1-model1.rb').and_return(['tasks/t1-model1.rb'])
    allow(Dir).to receive(:glob).with('tasks/t1-model2.rb').and_return(['tasks/t1-model2.rb'])
    allow(Dir).to receive(:glob).with('tasks/t1-nonexistent.rb').and_return([])
  end

  describe '#run_all_tests' do
    it 'runs tests only for mock solutions' do
      results = runner.run_all_tests
      expect(results['t1'].keys).to contain_exactly('model1', 'model2')
      expect(results['t1']['model1']).to be true
      expect(results['t1']['model2']).to be false
    end
  end

  describe '#run_task_tests' do
    it 'runs tests only for mock solutions of specific task' do
      results = runner.run_task_tests('t1')
      expect(results['t1'].keys).to contain_exactly('model1', 'model2')
      expect(results['t1']['model1']).to be true
      expect(results['t1']['model2']).to be false
    end

    it 'returns empty hash for invalid task format' do
      results = runner.run_task_tests('invalid')
      expect(results).to eq({})
    end

    it 'returns empty hash when test file missing' do
      allow(File).to receive(:exist?).with('tasks/t1-assert.rb').and_return(false)
      results = runner.run_task_tests('t1')
      expect(results).to eq({})
    end
  end

  describe '#run_model_tests' do
    it 'runs test for correct solution' do
      results = runner.run_model_tests('t1', 'model1')
      expect(results['t1']['model1']).to be true
    end

    it 'detects incorrect solution' do
      results = runner.run_model_tests('t1', 'model2')
      expect(results['t1']['model2']).to be false
    end

    it 'returns empty hash for missing solution' do
      results = runner.run_model_tests('t1', 'nonexistent')
      expect(results).to eq({})
    end
  end

  describe 'error handling' do
    it 'handles syntax errors' do
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  a + b # missing end")
      results = runner.run_model_tests('t1', 'model1')
      expect(results['t1']['model1']).to be false
    end

    it 'handles timeouts' do
      runner = described_class.new(timeout: 1, log_level: 'none')
      allow(File).to receive(:read).with('tasks/t1-model1.rb').and_return("def add(a, b)\n  while true; end\n  a + b\nend")
      results = runner.run_model_tests('t1', 'model1')
      expect(results['t1']['model1']).to be false
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
end
