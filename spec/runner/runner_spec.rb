require 'spec_helper'
require_relative '../../lib/runner/runner'

RSpec.describe Runner::Runner do
  let(:runner) { described_class.new(log_level: :debug) }
  let(:solution1_content) { "def add(a, b)\n  a + b\nend" }
  let(:solution2_content) { "def add(a, b)\n  a - b\nend" }
  let(:test_content) do
    <<~RUBY
      assert_equal 3, add(1, 2)
      assert_equal 0, add(0, 0)
    RUBY
  end

  before do
    FileUtils.mkdir_p('spec/tmp/tasks')
  end

  after do
    FileUtils.rm_rf('spec/tmp/tasks')
  end

  describe '#initialize' do
    it 'sets default options' do
      runner = described_class.new
      expect(runner.instance_variable_get(:@timeout)).to eq(5)
      expect(runner.instance_variable_get(:@generate_reports)).to be false
    end

    it 'sets custom options' do
      runner = described_class.new(timeout: 10, generate_reports: true)
      expect(runner.instance_variable_get(:@timeout)).to eq(10)
      expect(runner.instance_variable_get(:@generate_reports)).to be true
    end
  end

  describe '#run_all_tests' do
    context 'when no solution files exist' do
      it 'returns empty hash and logs error' do
        allow(Dir).to receive(:glob).and_return([])
        expect(runner.run_all_tests).to eq({})
      end
    end

    context 'when solution files exist' do
      before do
        allow(Dir).to receive(:glob).and_return(['tasks/t1-model1.rb', 'tasks/t1-model2.rb'])
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:read).and_return(solution1_content)
        allow(runner).to receive(:test_solution).and_return(true)
      end

      it 'runs tests for all solutions' do
        result = runner.run_all_tests
        expect(result).to be_a(Hash)
        expect(result.keys).to include('t1')
        expect(result['t1']).to eq({'model1' => true, 'model2' => true})
      end
    end
  end

  describe '#run_task_tests' do
    context 'with invalid task format' do
      it 'returns empty hash and logs error' do
        expect(runner.run_task_tests('invalid')).to eq({})
      end
    end

    context 'with valid task format' do
      before do
        File.write('spec/tmp/tasks/t1-model1.rb', solution1_content)
        File.write('spec/tmp/tasks/t1-assert.rb', test_content)
      end

      it 'runs tests for the specified task' do
        allow(Dir).to receive(:glob).and_return(['spec/tmp/tasks/t1-model1.rb'])
        result = runner.run_task_tests('t1')
        expect(result).to be_a(Hash)
        expect(result.keys).to include('t1')
      end
    end
  end

  describe '#run_model_tests' do
    context 'with invalid model format' do
      it 'returns empty hash and logs error' do
        expect(runner.run_model_tests('t1', 'invalid model')).to eq({})
      end
    end

    context 'with valid model format' do
      before do
        File.write('spec/tmp/tasks/t1-model1.rb', solution1_content)
        File.write('spec/tmp/tasks/t1-assert.rb', test_content)
      end

      it 'runs tests for the specified model' do
        allow(Dir).to receive(:glob).and_return(['spec/tmp/tasks/t1-model1.rb'])
        result = runner.run_model_tests('t1', 'model1')
        expect(result).to be_a(Hash)
        expect(result['t1']).to be_a(Hash)
        expect(result['t1'].keys).to include('model1')
      end
    end
  end

  describe '#find_solution_files' do
    before do
      File.write('spec/tmp/tasks/t1-model1.rb', solution1_content)
      File.write('spec/tmp/tasks/t1-model2.rb', solution2_content)
      File.write('spec/tmp/tasks/t1-assert.rb', test_content)
    end

    it 'finds all solution files' do
      allow(Dir).to receive(:glob).and_return(['spec/tmp/tasks/t1-model1.rb', 'spec/tmp/tasks/t1-model2.rb'])
      files = runner.send(:find_solution_files)
      expect(files).to include('spec/tmp/tasks/t1-model1.rb')
      expect(files).to include('spec/tmp/tasks/t1-model2.rb')
    end

    it 'finds solution files for specific task' do
      allow(Dir).to receive(:glob).and_return(['spec/tmp/tasks/t1-model1.rb'])
      files = runner.send(:find_solution_files, 't1')
      expect(files).to include('spec/tmp/tasks/t1-model1.rb')
    end
  end

  describe '#test_solution' do
    let(:task) { 't1' }
    let(:solution_file) { 'spec/tmp/tasks/t1-model1.rb' }
    let(:not_exist_solution_file) { 'spec/tmp/tasks/t1-model2.rb' }
    let(:test_file) { 'spec/tmp/tasks/t1-assert.rb' }

    before do
      File.write(solution_file, solution1_content)
      File.write(test_file, test_content)
    end

    context 'when solution file does not exist' do
      it 'returns false and logs error' do
        expect(runner.send(:test_solution, 'non_existent.rb')).to be false
      end
    end

    context 'when test file does not exist' do
      it 'returns false and logs error' do
        expect(runner.send(:test_solution, not_exist_solution_file)).to be false
      end
    end

    context 'when solution file is empty' do
      before do
        File.write(solution_file, '')
      end

      it 'returns false and logs error' do
        expect(runner.send(:test_solution, solution_file)).to be false
      end
    end

    context 'when solution has syntax error' do
      before do
        File.write(solution_file, "def add(a, b)\n  a + b\n") # missing end
      end

      it 'returns false and logs error' do
        expect(runner.send(:test_solution, solution_file)).to be false
      end
    end

    context 'when solution is valid' do
      it 'runs tests and returns result' do
        allow(File).to receive(:read).with(solution_file).and_return(solution1_content)
        allow(File).to receive(:read).with(test_file).and_return(test_content)
        expect(runner.send(:test_solution, solution_file)).to be true
      end
    end
  end

  # describe '#display_results' do
  #   before do
  #     runner.instance_variable_set(:@results, {
  #       't1' => { 'model1' => true, 'model2' => false },
  #       't2' => { 'model1' => true, 'model2' => true }
  #     })
  #   end

  #   # context 'when generate_reports is true' do
  #   #   before do
  #   #     runner.instance_variable_set(:@generate_reports, true)
  #   #   end

  #   #   it 'generates reports and displays results' do
  #   #     expect { runner.send(:display_results, ['t1', 't2'], ['model1', 'model2']) }
  #   #       .to output(/model1/).to_stdout
  #   #       .and output(/model2/).to_stdout
  #   #   end
  #   # end

  #   # context 'when generate_reports is false' do
  #   #   before { runner.instance_variable_set(:@generate_reports, false) }

  #   #   it 'displays results without generating reports' do
  #   #     expect { runner.send(:display_results, ['t1', 't2'], ['model1', 'model2']) }
  #   #       .to output(/model1/).to_stdout
  #   #       .and output(/model2/).to_stdout
  #   #   end
  #   # end
  # end

  describe '#model_stats' do
    it 'returns statistics for all models' do
      allow(runner).to receive(:find_solution_files).and_return(['tasks/t1-model1.rb', 'tasks/t1-model2.rb', 'tasks/t1-model3.rb', 'tasks/t2-model1.rb', 'tasks/t2-model2.rb', 'tasks/t2-model3.rb'])
      # allow(runner).to receive(:run_all_tests).and_return(
      #   {
      #     't1' => { 'model1' => true, 'model2' => false },
      #     't2' => { 'model1' => true, 'model2' => true }
      #   }
      # )
      runner.instance_variable_set(:@results, {
          't1' => { 'model1' => true, 'model2' => false, 'model3' => true },
          't2' => { 'model1' => false, 'model2' => true, 'model3' => true }
        })

      stats = runner.send(:model_stats)
      expect(stats).to eq(
        [
          ['model3', { total: 2, passed: 2, percentage: 100 }],
          ['model1', { total: 2, passed: 1, percentage: 50 }],
          ['model2', { total: 2, passed: 1, percentage: 50 }]
        ]
      )
    end

    it 'sorts models by percentage in descending order' do
      allow(runner).to receive(:find_solution_files).and_return(['tasks/t1-model1.rb', 'tasks/t1-model2.rb', 'tasks/t1-model3.rb', 'tasks/t2-model1.rb', 'tasks/t2-model2.rb', 'tasks/t2-model3.rb'])
      runner.instance_variable_set(:@results, {
          't1' => { 'model1' => true, 'model2' => false, 'model3' => true },
          't2' => { 'model1' => false, 'model2' => true, 'model3' => true }
        })
      stats = runner.send(:model_stats)
      expect(stats).to eq(
        [
          ['model3', { total: 2, passed: 2, percentage: 100 }],
          ['model1', { total: 2, passed: 1, percentage: 50 }],
          ['model2', { total: 2, passed: 1, percentage: 50 }]
        ]
      )
    end
  end
end 