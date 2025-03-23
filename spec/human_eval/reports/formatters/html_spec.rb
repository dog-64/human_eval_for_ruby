# frozen_string_literal: true

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
      ['model2', 50]
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
    before do
      formatter.generate
    end

    it 'создает файл с общим отчетом' do
      total_report = File.join(output_dir, 'human_eval_for_ruby_report_total.html')
      expect(File.exist?(total_report)).to be true
    end

    it 'создает файл с полным отчетом' do
      full_report = File.join(output_dir, 'human_eval_for_ruby_report_full.html')
      expect(File.exist?(full_report)).to be true
    end

    context 'общий отчет' do
      let(:total_report_content) do
        File.read(File.join(output_dir, 'human_eval_for_ruby_report_total.html'))
      end

      it 'содержит заголовок' do
        expect(total_report_content).to include('<h1>Суммарный отчет о тестировании моделей</h1>')
      end

      it 'содержит дату' do
        expect(total_report_content).to include("<p>Дата: #{timestamp}</p>")
      end

      it 'содержит таблицу со статистикой моделей' do
        expect(total_report_content).to include('<div class=\'model-results\'><table>')
        expect(total_report_content).to include('<tr><th>Модель</th><th>Успешность</th></tr>')
        model_stats.each do |model, percentage|
          expect(total_report_content).to include("<tr><td>#{model}</td><td>#{percentage}%</td></tr>")
        end
      end
    end

    context 'полный отчет' do
      let(:full_report_content) do
        File.read(File.join(output_dir, 'human_eval_for_ruby_report_full.html'))
      end

      it 'содержит заголовок' do
        expect(full_report_content).to include('<h1>Полный отчет о тестировании моделей</h1>')
      end

      it 'содержит дату' do
        expect(full_report_content).to include("<p>Дата: #{timestamp}</p>")
      end

      it 'содержит таблицу со статистикой моделей' do
        expect(full_report_content).to include('<div class=\'model-results\'><table>')
        expect(full_report_content).to include('<tr><th>Модель</th><th>Успешность</th></tr>')
        model_stats.each do |model, percentage|
          expect(full_report_content).to include("<tr><td>#{model}</td><td>#{percentage}%</td></tr>")
        end
      end

      it 'содержит таблицу с результатами задач' do
        expect(full_report_content).to include('<div class=\'task-results\'><table>')
        expect(full_report_content).to include('<tr><th>Задача</th>')
        task_results.each do |task, results|
          expect(full_report_content).to include("<tr><td>#{task}</td>")
          results.each do |_, success|
            status = success ? '✓' : '✗'
            css_class = success ? 'success' : 'failure'
            expect(full_report_content).to include("<td class='#{css_class}'>#{status}</td>")
          end
        end
      end
    end
  end

  describe '#html_header' do
    let(:header) { formatter.send(:html_header) }

    it 'содержит DOCTYPE' do
      expect(header).to include('<!DOCTYPE html>')
    end

    it 'содержит метатег с кодировкой' do
      expect(header).to include('<meta charset="UTF-8">')
    end

    it 'содержит метатег для viewport' do
      expect(header).to include('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
    end

    it 'содержит заголовок страницы' do
      expect(header).to include('<title>Отчет о тестировании моделей</title>')
    end

    it 'содержит стили' do
      expect(header).to include('<style>')
      expect(header).to include('body {')
      expect(header).to include('.success {')
      expect(header).to include('.failure {')
    end
  end
end 