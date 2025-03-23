# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/run_tests'

RSpec.describe RunTests do
  let(:runner) { described_class.new }
  let(:task) { 't1' }
  let(:model) { 'gpt-4' }
  let(:test_file) { "tasks/#{task}-asserts.rb" }
  let(:solution_file) { "tasks/#{task}-#{model}.rb" }

  before do
    allow(Dir).to receive(:glob).and_return([])
    allow(File).to receive(:exist?).and_return(false)
    allow(File).to receive(:read).and_return('')
  end

  describe '#run_all_tests' do
    let(:solutions) { ["tasks/t1-gpt-4.rb", "tasks/t2-gpt-4.rb"] }
    let(:tasks) { ['t1', 't2'] }
    let(:models) { ['gpt-4'] }

    before do
      allow(Dir).to receive(:glob).with('tasks/t*-*.rb').and_return(solutions)
      tasks.each do |task|
        allow(Dir).to receive(:glob).with("tasks/#{task}-*.rb").and_return([solutions.find { |s| s.include?(task) }])
      end
      solutions.each do |solution|
        allow(File).to receive(:exist?).with(solution).and_return(true)
        test_file = solution.sub(/-gpt-4\.rb$/, '-asserts.rb')
        allow(File).to receive(:exist?).with(test_file).and_return(true)
      end
      allow(runner).to receive(:test_solution).and_return(true)
    end

    it 'runs tests for all solutions' do
      expect(runner).to receive(:test_solution).exactly(2).times.and_return(true)
      expect { runner.run_all_tests }.to output(/Score.*100%/).to_stdout
    end
  end

  describe '#run_task_tests' do
    context 'when test file exists' do
      before do
        allow(File).to receive(:exist?).with(test_file).and_return(true)
        allow(Dir).to receive(:glob).with("tasks/#{task}-*.rb").and_return([solution_file])
        allow(File).to receive(:exist?).with(solution_file).and_return(true)
        allow(runner).to receive(:test_solution).and_return(true)
      end

      it 'runs tests for the task' do
        expect(runner).to receive(:test_solution).once.and_return(true)
        expect { runner.run_task_tests(task) }.to output(/Score.*100%/).to_stdout
      end
    end

    context 'when test file does not exist' do
      it 'displays error message' do
        expect { runner.run_task_tests(task) }.to output(/Файл с тестами.*не найден/).to_stdout
      end
    end
  end

  describe '#run_model_tests' do
    context 'when solution exists' do
      before do
        allow(Dir).to receive(:glob).with("tasks/#{task}-#{model}.rb").and_return([solution_file])
        allow(File).to receive(:exist?).with(solution_file).and_return(true)
        allow(File).to receive(:exist?).with(test_file).and_return(true)
        allow(runner).to receive(:test_solution).and_return(true)
      end

      it 'runs tests for the model' do
        expect(runner).to receive(:test_solution).once.and_return(true)
        expect { runner.run_model_tests(task, model) }.to output(/Score.*100%/).to_stdout
      end
    end

    context 'when solution does not exist' do
      it 'displays error message' do
        expect { runner.run_model_tests(task, model) }.to output(/Решение для задачи.*не найдено/).to_stdout
      end
    end
  end

  describe '#test_solution' do
    context 'when both files exist' do
      before do
        allow(File).to receive(:exist?).with(solution_file).and_return(true)
        allow(File).to receive(:exist?).with(test_file).and_return(true)
      end

      it 'returns true when test passes' do
        expect(runner.send(:test_solution, task, solution_file)).to be true
      end

      it 'returns false when test fails' do
        allow_any_instance_of(Module).to receive(:module_eval).and_raise(StandardError)
        expect(runner.send(:test_solution, task, solution_file)).to be false
      end
    end

    context 'when solution file does not exist' do
      it 'returns false' do
        expect(runner.send(:test_solution, task, solution_file)).to be false
      end
    end

    context 'when test file does not exist' do
      before do
        allow(File).to receive(:exist?).with(solution_file).and_return(true)
      end

      it 'returns false' do
        expect(runner.send(:test_solution, task, solution_file)).to be false
      end
    end
  end
end 