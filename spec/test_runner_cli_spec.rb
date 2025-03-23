# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/test_runner_cli'

RSpec.describe TestRunner::CLI do
  let(:cli) { described_class.new }
  let(:runner_double) { instance_double('TestRunner::Runner') }

  before do
    allow(TestRunner::Runner).to receive(:new).and_return(runner_double)
  end

  describe '#all' do
    before do
      allow(runner_double).to receive(:run_all_tests)
    end

    it 'creates runner with default options' do
      expect(TestRunner::Runner).to receive(:new).with(
        hash_including(
          'log_level' => 'normal',
          'report_total' => false
        )
      )
      cli.all
    end

    it 'calls run_all_tests on runner' do
      expect(runner_double).to receive(:run_all_tests)
      cli.all
    end

    context 'with custom options' do
      let(:cli) { described_class.new([], { 'log_level' => 'debug', 'report_total' => true }) }

      it 'creates runner with custom options' do
        expect(TestRunner::Runner).to receive(:new).with(
          hash_including(
            'log_level' => 'debug',
            'report_total' => true
          )
        )
        cli.all
      end
    end
  end

  describe '#task' do
    let(:task_number) { '42' }

    before do
      allow(runner_double).to receive(:run_task_tests)
    end

    it 'creates runner with default options' do
      expect(TestRunner::Runner).to receive(:new).with(
        hash_including(
          'log_level' => 'normal',
          'report_total' => false
        )
      )
      cli.task(task_number)
    end

    it 'calls run_task_tests with task number' do
      expect(runner_double).to receive(:run_task_tests).with(task_number)
      cli.task(task_number)
    end
  end

  describe '#model' do
    let(:task_number) { '42' }
    let(:model) { 'gpt-4' }

    before do
      allow(runner_double).to receive(:run_model_tests)
    end

    it 'creates runner with default options' do
      expect(TestRunner::Runner).to receive(:new).with(
        hash_including(
          'log_level' => 'normal',
          'report_total' => false
        )
      )
      cli.model(task_number, model)
    end

    it 'calls run_model_tests with task number and model' do
      expect(runner_double).to receive(:run_model_tests).with(task_number, model)
      cli.model(task_number, model)
    end
  end

  describe '.exit_on_failure?' do
    it 'returns true' do
      expect(described_class.exit_on_failure?).to be true
    end
  end
end 