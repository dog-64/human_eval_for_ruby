# frozen_string_literal: true

require 'spec_helper'
require 'test_runner/cli'

RSpec.describe TestRunner::CLI do
  describe '#tests' do
    let(:runner) { instance_double(TestRunner::Runner) }

    before do
      allow(TestRunner::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:run_all_tests)
      allow(runner).to receive(:run_task_tests)
      allow(runner).to receive(:run_model_tests)
    end

    context 'когда не указаны опции' do
      it 'запускает все тесты' do
        cli = described_class.new([], {})
        expect(runner).to receive(:run_all_tests)
        cli.tests
      end
    end

    context 'когда указана опция --task' do
      it 'запускает тесты для конкретной задачи' do
        cli = described_class.new([], { task: 'T1' })
        expect(runner).to receive(:run_task_tests).with('T1')
        cli.tests
      end
    end

    context 'когда указаны опции --task и --model' do
      it 'запускает тесты для конкретной модели в задаче' do
        cli = described_class.new([], { task: 'T1', model: 'model1' })
        expect(runner).to receive(:run_model_tests).with('T1', 'model1')
        cli.tests
      end
    end

    context 'когда указана только опция --model' do
      it 'запускает тесты для конкретной модели' do
        cli = described_class.new([], { model: 'model1' })
        expect(runner).to receive(:run_model_tests).with('', 'model1')
        cli.tests
      end
    end
  end
end 