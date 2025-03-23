# frozen_string_literal: true

require 'spec_helper'
require 'tmpdir'

RSpec.describe HumanEval::Reports::Generator do
  let(:output_dir) { Dir.mktmpdir('test_reports_') }
  let(:options) { { output_dir: output_dir, format: 'all' } }
  let(:generator) { described_class.new(options) }

  after do
    FileUtils.remove_entry(output_dir) if Dir.exist?(output_dir)
  end

  describe '#initialize' do
    it 'accepts valid options' do
      expect { described_class.new(options) }.not_to raise_error
    end

    it 'raises error for invalid format' do
      expect do
        described_class.new(options.merge(format: 'invalid'))
      end.to raise_error(HumanEval::Reports::Error, /Неизвестный формат/)
    end

    it 'raises error for empty output directory' do
      expect do
        described_class.new(options.merge(output_dir: ''))
      end.to raise_error(HumanEval::Reports::Error, /Не указана директория/)
    end
  end

  describe '#generate' do
    let(:test_results) do
      {
        model_stats: { 'model1' => 100, 'model2' => 50 },
        task_results: { 't1' => { 'model1' => true, 'model2' => false } }
      }
    end

    before do
      allow_any_instance_of(TestRunner::Runner).to receive(:run_all_tests).and_return(test_results)
    end

    it 'generates all report files' do
      generator.generate

      expect(File).to exist(File.join(output_dir, 'human_eval_for_ruby_report_total.html'))
      expect(File).to exist(File.join(output_dir, 'human_eval_for_ruby_report_full.html'))
      expect(File).to exist(File.join(output_dir, 'total.md'))
    end

    context 'when format is html' do
      let(:options) { { output_dir: output_dir, format: 'html' } }

      it 'generates only HTML reports' do
        generator.generate

        expect(File).to exist(File.join(output_dir, 'human_eval_for_ruby_report_total.html'))
        expect(File).to exist(File.join(output_dir, 'human_eval_for_ruby_report_full.html'))
        expect(File).not_to exist(File.join(output_dir, 'total.md'))
      end
    end

    context 'when format is markdown' do
      let(:options) { { output_dir: output_dir, format: 'markdown' } }

      it 'generates only Markdown reports' do
        generator.generate

        expect(File).not_to exist(File.join(output_dir, 'human_eval_for_ruby_report_total.html'))
        expect(File).not_to exist(File.join(output_dir, 'human_eval_for_ruby_report_full.html'))
        expect(File).to exist(File.join(output_dir, 'total.md'))
      end
    end
  end
end 