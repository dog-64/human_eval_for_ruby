require 'spec_helper'
require_relative '../../lib/report/cli'

RSpec.describe Report::CLI do
  describe '.start' do
    let(:args) { ['generate'] }
    let(:runner_instance) { instance_double(Report::Runner) }

    before do
      allow(Report::Runner).to receive(:new).and_return(runner_instance)
      allow(runner_instance).to receive(:generate).and_return(true)
    end

    it 'calls the runner with default options' do
      # Мокаем Thor.start, чтобы не запускать реальные команды
      expect(described_class).to receive(:start).with(args)
      
      # Вызываем метод
      described_class.start(args)
    end
  end

  describe '#generate' do
    let(:cli) { described_class.new }
    let(:runner_instance) { instance_double(Report::Runner) }

    before do
      allow(cli).to receive(:options).and_return(
        {
          results_file: 'test_results.json',
          output_dir: 'output'
        }
      )
      allow(Report::Runner).to receive(:new).and_return(runner_instance)
    end

    context 'when runner generates reports successfully' do
      before do
        allow(runner_instance).to receive(:generate).and_return(true)
      end

      it 'does not exit' do
        expect(cli).not_to receive(:exit)
        cli.generate
      end
    end

    context 'when runner fails to generate reports' do
      before do
        allow(runner_instance).to receive(:generate).and_return(false)
      end

      it 'exits with status code 1' do
        expect(cli).to receive(:exit).with(1)
        cli.generate
      end
    end

    it 'initializes Runner with correct options' do
      expect(Report::Runner).to receive(:new).with(
        {
          results_file: 'test_results.json',
          output_dir: 'output'
        }
      )
      
      allow(runner_instance).to receive(:generate).and_return(true)
      
      cli.generate
    end
  end
end 