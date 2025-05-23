require 'spec_helper'
require 'runner/cli'

RSpec.describe Runner::CLI do
  describe '#tests' do
    let(:runner) { instance_double(Runner::Runner) }

    before do
      allow(Runner::Runner).to receive(:new).and_return(runner)
      allow(runner).to receive(:run_tests)
    end

    context 'когда не указаны опции' do
      it 'запускает все тесты' do
        cli = described_class.new([], {})
        expect(runner).to receive(:run_tests).with(task: nil, model: nil)
        cli.tests
      end
    end

    context 'когда указана опция --task' do
      it 'запускает тесты для конкретной задачи' do
        cli = described_class.new([], { task: 'T1' })
        expect(runner).to receive(:run_tests).with(task: 'T1', model: nil)
        cli.tests
      end
    end

    context 'когда указаны опции --task и --model' do
      it 'запускает тесты для конкретной модели в задаче' do
        cli = described_class.new([], { task: 'T1', model: 'model1' })
        expect(runner).to receive(:run_tests).with(task: 'T1', model: 'model1')
        cli.tests
      end
    end

    context 'когда указана только опция --model' do
      it 'запускает тесты для конкретной модели' do
        cli = described_class.new([], { model: 'model1' })
        expect(runner).to receive(:run_tests).with(task: nil, model: 'model1')
        cli.tests
      end
    end
  end
end
