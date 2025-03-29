require 'spec_helper'
require 'fileutils'

RSpec.describe HumanEval::Reports::Formatters::HTML do
  let(:output_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:task_results) do
    {
      't1' => { 'model1' => true, 'model2' => false },
      't2' => { 'model1' => false, 'model2' => true }
    }
  end
  let(:model_stats) do
    [
      ['model1', 50],
      ['model2', 25]
    ]
  end
  let(:timestamp) { '2024-03-20 12:00:00' }
  let(:formatter) do
    described_class.new(
      output_dir: output_dir,
      task_results: task_results,
      model_stats: model_stats,
      timestamp: timestamp
    )
  end

  before(:each) do
    FileUtils.mkdir_p(output_dir)
  end

  after(:each) do
    FileUtils.rm_rf(output_dir)
  end

  describe '#generate' do
    let(:total_report) { File.join(output_dir, 'human_eval_for_ruby_report_total.html') }
    let(:full_report) { File.join(output_dir, 'human_eval_for_ruby_report_full.html') }
    let(:style_file) { File.join(output_dir, 'style.css') }

    before do
      formatter.generate
    end

    it 'создает файл с общим отчетом' do
      expect(File.exist?(total_report)).to be true
    end

    it 'создает файл с полным отчетом' do
      expect(File.exist?(full_report)).to be true
    end

    it 'создает файл стилей' do
      expect(File.exist?(style_file)).to be true
    end

    context 'общий отчет' do
      let(:content) { File.read(total_report) }

      it 'содержит заголовок' do
        expect(content).to include('<title>Отчет о тестировании моделей</title>')
      end

      it 'содержит дату' do
        expect(content).to include(timestamp)
      end

      it 'содержит таблицу со статистикой моделей' do
        expect(content).to include('<table')
        expect(content).to include('model1')
        expect(content).to include('50%')
        expect(content).to include('model2')
        expect(content).to include('25%')
      end
    end

    context 'полный отчет' do
      let(:content) { File.read(full_report) }

      it 'содержит заголовок' do
        expect(content).to include('<title>Отчет о тестировании моделей</title>')
      end

      it 'содержит дату' do
        expect(content).to include(timestamp)
      end

      it 'содержит таблицу со статистикой моделей' do
        expect(content).to include('<table')
        expect(content).to include('model1')
        expect(content).to include('50%')
        expect(content).to include('model2')
        expect(content).to include('25%')
      end

      it 'содержит таблицу с результатами задач' do
        expect(content).to include('<table')
        expect(content).to include('t1')
        expect(content).to include('t2')
        expect(content).to include('✅')
        expect(content).to include('❌')
      end
    end
  end

  describe '#html_header' do
    let(:header) { formatter.send(:html_header) }

    it 'содержит мета-теги' do
      expect(header).to include('<meta charset="UTF-8">')
      expect(header).to include('<meta name="viewport"')
    end

    it 'содержит ссылку на файл стилей' do
      expect(header).to include('<link rel="stylesheet" href="style.css">')
    end

    it 'содержит заголовок' do
      expect(header).to include('<title>Отчет о тестировании моделей</title>')
    end
  end
end 
