require 'spec_helper'
require_relative '../../lib/runner/cli'

RSpec.describe Runner::CLI do
  let(:cli) { described_class.new }

  describe '#all' do
    it 'runs all tests with default options' do
      runner = instance_double(Runner::Runner)
      expect(Runner::Runner).to receive(:new).with(
        log_level: Runner::CLI::LOG_LEVELS['normal'],
        timeout: 5,
        generate_reports: true
      ).and_return(runner)
      expect(runner).to receive(:run_all_tests)
      cli.all
    end

    it 'runs all tests with custom options' do
      runner = instance_double(Runner::Runner)
      expect(Runner::Runner).to receive(:new).with(
        log_level: Runner::CLI::LOG_LEVELS['debug'],
        timeout: 10,
        generate_reports: true
      ).and_return(runner)
      expect(runner).to receive(:run_all_tests)
      cli.options = { log_level: 'debug', timeout: 10 }
      cli.all
    end
  end

  describe '#model' do
    it 'runs tests for specific model' do
      runner = instance_double(Runner::Runner)
      expect(Runner::Runner).to receive(:new).with(
        log_level: Runner::CLI::LOG_LEVELS['normal'],
        timeout: 5,
        generate_reports: false
      ).and_return(runner)
      expect(runner).to receive(:run_model_tests).with(nil, 'gpt-4')
      cli.model('gpt-4')
    end

    it 'runs tests for model with custom options' do
      runner = instance_double(Runner::Runner)
      expect(Runner::Runner).to receive(:new).with(
        log_level: Runner::CLI::LOG_LEVELS['debug'],
        timeout: 10,
        generate_reports: false
      ).and_return(runner)
      expect(runner).to receive(:run_model_tests).with(nil, 'gpt-4')
      cli.options = { log_level: 'debug', timeout: 10 }
      cli.model('gpt-4')
    end

    it 'validates model name format' do
      expect { cli.model('invalid model') }.to raise_error(Runner::CLI::Error, 'Неверный формат названия модели')
    end
  end

  describe '#task' do
    it 'runs tests for specific task' do
      runner = instance_double(Runner::Runner)
      expect(Runner::Runner).to receive(:new).with(
        log_level: Runner::CLI::LOG_LEVELS['normal'],
        timeout: 5,
        generate_reports: false
      ).and_return(runner)
      expect(runner).to receive(:run_task_tests).with('t1')
      cli.task('t1')
    end

    it 'runs tests for task with custom options' do
      runner = instance_double(Runner::Runner)
      expect(Runner::Runner).to receive(:new).with(
        log_level: Runner::CLI::LOG_LEVELS['debug'],
        timeout: 10,
        generate_reports: false
      ).and_return(runner)
      expect(runner).to receive(:run_task_tests).with('t1')
      cli.options = { log_level: 'debug', timeout: 10 }
      cli.task('t1')
    end

    it 'validates task name format' do
      expect { cli.task('task1') }.to raise_error(Runner::CLI::Error, "Неверный формат задания. Ожидается формат 't<число>' (например, 't1')")
    end
  end

  describe 'CLI interface' do
    let(:runner) { instance_double(Runner::Runner) }

    before do
      allow(Runner::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:run_task_tests)
      allow(runner).to receive(:run_model_tests)
      allow(runner).to receive(:run_all_tests)
    end

    it 'handles --task argument correctly' do
      expect(runner).to receive(:run_task_tests).with('t1')
      Runner::CLI.start(['task', 't1'])
    end

    it 'handles --task argument with options' do
      expect(runner).to receive(:run_task_tests).with('t1')
      Runner::CLI.start(['task', 't1', '--log-level', 'debug', '--timeout', '10'])
    end

    it 'handles --model argument correctly' do
      expect(runner).to receive(:run_model_tests).with(nil, 'gpt-4')
      Runner::CLI.start(['model', 'gpt-4'])
    end

    it 'handles --all argument correctly' do
      expect(runner).to receive(:run_all_tests)
      Runner::CLI.start(['all'])
    end

    it 'handles --all argument with options' do
      expect(runner).to receive(:run_all_tests)
      Runner::CLI.start(['all', '--log-level', 'debug', '--timeout', '10'])
    end

    context 'with invalid arguments' do
      it 'raises error when --task is used without value' do
        expect { Runner::CLI.start(['--task']) }.to raise_error(SystemExit)
      end

      it 'raises error when --model is used without value' do
        expect { Runner::CLI.start(['--model']) }.to raise_error(SystemExit)
      end

      it 'raises error when task has invalid format' do
        expect { Runner::CLI.start(['task', 'invalid']) }.to raise_error(SystemExit)
      end

      it 'raises error when model has invalid format' do
        expect { Runner::CLI.start(['model', 'invalid model']) }.to raise_error(SystemExit)
      end
    end
  end
end 