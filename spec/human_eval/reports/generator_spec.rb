# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'
require 'json'

RSpec.describe HumanEval::Reports::Generator do
  let(:output_dir) { File.join('tmp', 'test_reports') }
  let(:options) { { output_dir: output_dir, format: 'all' } }
  let(:generator) { described_class.new(options) }

  before(:all) do
    ENV['RUBY_ENV'] = 'test'
  end

  after(:all) do
    ENV['RUBY_ENV'] = nil
  end

  before(:each) do
    FileUtils.mkdir_p(output_dir)
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('reports/results.json').and_return(true)
    allow(File).to receive(:read).with('reports/results.json').and_return('{}')
  end

  after(:each) do
    FileUtils.rm_rf(output_dir)
  end

  describe '#initialize' do
    it 'accepts valid options' do
      expect { described_class.new(options) }.not_to raise_error
    end

    it 'raises error for invalid format' do
      expect do
        described_class.new(options.merge(format: 'invalid'))
      end.to raise_error(HumanEval::Reports::Error, /Неверный формат отчета/)
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
        't1' => { 'model1' => true, 'model2' => false },
        't2' => { 'model1' => true, 'model2' => true }
      }
    end

    before do
      allow(File).to receive(:exist?).with(HumanEval::Reports::Generator::RESULTS_FILE).and_return(true)
      allow(File).to receive(:read).with(HumanEval::Reports::Generator::RESULTS_FILE).and_return(test_results.to_json)
    end

    it 'generates all report files' do
      generator.generate

      expect(File).to exist(File.join(output_dir, 'report.html'))
      expect(File).to exist(File.join(output_dir, 'report.md'))
      expect(File).to exist(File.join(output_dir, 'style.css'))
    end

    context 'when format is invalid' do
      let(:options) { { output_dir: output_dir, format: 'invalid' } }

      it 'raises an error' do
        expect { generator.generate }.to raise_error(HumanEval::Reports::Error, /Неверный формат отчета/)
      end
    end

    context 'when format is html' do
      let(:options) { { output_dir: output_dir, format: 'html' } }

      it 'generates only HTML report' do
        generator.generate
        expect(File.exist?(File.join(output_dir, 'report.html'))).to be true
        expect(File.exist?(File.join(output_dir, 'report.md'))).to be false
      end
    end

    context 'when format is markdown' do
      let(:options) { { output_dir: output_dir, format: 'markdown' } }

      it 'generates only Markdown report' do
        generator.generate
        expect(File.exist?(File.join(output_dir, 'report.md'))).to be true
        expect(File.exist?(File.join(output_dir, 'report.html'))).to be false
      end
    end

    context 'when format is all' do
      let(:options) { { output_dir: output_dir, format: 'all' } }

      it 'generates both HTML and Markdown reports' do
        generator.generate
        expect(File.exist?(File.join(output_dir, 'report.html'))).to be true
        expect(File.exist?(File.join(output_dir, 'report.md'))).to be true
      end
    end
  end
end 