require 'spec_helper'
require_relative '../lib/human_eval/cli'
require_relative '../lib/human_eval/converter'

RSpec.describe HumanEval::CLI do
  let(:cli) { described_class.new }
  let(:converter_double) { instance_double('HumanEvalConverter') }

  describe '#version' do
    it 'outputs version information' do
      expect { cli.version }.to output(/Human Eval Converter version 1\.0\.0/).to_stdout
    end
  end

  describe '#help' do
    it 'displays general help without command' do
      expect { cli.help }.to output(/Human Eval Converter - инструмент для конвертации задач/).to_stdout
    end

    it 'displays command help with command' do
      expect { cli.help('convert') }.to output(/Конвертирует задачи из формата human-eval/).to_stdout
    end
  end

  describe '#convert' do
    let(:source) { '_src/HumanEval.jsonl' }
    let(:target) { 'tasks' }

    before do
      allow(HumanEvalConverter).to receive(:new).and_return(converter_double)
      allow(converter_double).to receive(:process)
    end

    context 'with default options' do
      it 'initializes converter with default options' do
        expect(HumanEvalConverter).to receive(:new).with(
          source,
          target,
          {
            create_rules: nil,
            keep_existing: nil,
            preserve_old: nil,
            task_number: nil,
            log_level: nil
          }
        )

        cli.convert(source, target)
      end

      it 'calls process on converter' do
        expect(converter_double).to receive(:process)
        cli.convert(source, target)
      end
    end

    context 'with --create-rules option' do
      before do
        cli.options = { create_rules: true }
      end

      it 'passes create_rules option to converter' do
        expect(HumanEvalConverter).to receive(:new).with(
          source,
          target,
          hash_including(create_rules: true)
        )

        cli.convert(source, target)
      end
    end

    context 'with --keep-existing option' do
      before do
        cli.options = { keep_existing: true }
      end

      it 'passes keep_existing option to converter' do
        expect(HumanEvalConverter).to receive(:new).with(
          source,
          target,
          hash_including(keep_existing: true)
        )

        cli.convert(source, target)
      end
    end

    context 'with --preserve-old option' do
      before do
        cli.options = { preserve_old: true }
      end

      it 'passes preserve_old option to converter' do
        expect(HumanEvalConverter).to receive(:new).with(
          source,
          target,
          hash_including(preserve_old: true)
        )

        cli.convert(source, target)
      end
    end

    context 'with --task option' do
      before do
        cli.options = { task: '42' }
      end

      it 'passes task_number option to converter' do
        expect(HumanEvalConverter).to receive(:new).with(
          source,
          target,
          hash_including(task_number: '42')
        )

        cli.convert(source, target)
      end
    end

    context 'with --log-level option' do
      before do
        cli.options = { log_level: 'debug' }
      end

      it 'passes log_level option to converter' do
        expect(HumanEvalConverter).to receive(:new).with(
          source,
          target,
          hash_including(log_level: 'debug')
        )

        cli.convert(source, target)
      end
    end

    context 'with --help option' do
      before do
        cli.options = { help: true }
      end

      it 'displays help instead of converting' do
        expect(HumanEvalConverter).not_to receive(:new)
        expect { cli.convert(source, target) }.to output(/Конвертирует задачи из формата human-eval/).to_stdout
      end
    end
  end

  describe '.exit_on_failure?' do
    it 'returns true' do
      expect(described_class.exit_on_failure?).to be true
    end
  end
end
