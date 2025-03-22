# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/human_eval/report_generator'

RSpec.describe HumanEval::ReportGenerator do
  let(:model_stats) { { 'model1' => 100, 'model2' => 50 } }
  let(:task_results) { { 't1' => { 'model1' => true, 'model2' => false } } }
  let(:results) { { model_stats: model_stats, task_results: task_results } }
  let(:generator) { described_class.new(results) }

  before(:each) do
    # Создаем временную директорию для отчетов
    FileUtils.mkdir_p('reports')
    
    # Мокаем методы работы с README.md
    allow_any_instance_of(HumanEval::ReportGenerator).to receive(:update_readme)
  end

  after(:each) do
    # Удаляем временные файлы после тестов
    FileUtils.rm_rf('reports')
  end

  describe '#generate_all' do
    it 'creates all report files' do
      generator.generate_all

      expect(File).to exist('reports/test_results.json')
      expect(File).to exist('reports/human_eval_for_ruby_report_total.html')
      expect(File).to exist('reports/human_eval_for_ruby_report_full.html')
      expect(File).to exist('reports/total.md')
    end

    it 'generates correct JSON report' do
      generator.generate_all
      json_content = JSON.parse(File.read('reports/test_results.json'))

      expect(json_content['models']).to eq(model_stats)
      expect(json_content['tasks']).to eq(task_results)
      expect(json_content).to have_key('timestamp')
    end

    it 'generates correct markdown report' do
      generator.generate_all
      md_content = File.read('reports/total.md')

      expect(md_content).to include('## Рейтинг')
      expect(md_content).to include('model1: 100%')
      expect(md_content).to include('model2: 50%')
    end

    it 'generates HTML reports with correct content' do
      generator.generate_all
      total_html = File.read('reports/human_eval_for_ruby_report_total.html')
      full_html = File.read('reports/human_eval_for_ruby_report_full.html')

      # Проверяем общие элементы
      [total_html, full_html].each do |html|
        expect(html).to include('<!DOCTYPE html>')
        expect(html).to include('<html lang="ru">')
        expect(html).to include('model1')
        expect(html).to include('100%')
        expect(html).to include('model2')
        expect(html).to include('50%')
      end

      # Проверяем специфичные элементы полного отчета
      expect(full_html).to include('Детальные результаты по задачам')
      expect(full_html).to include('t1')
      expect(full_html).to include('✓') # для успешного теста
      expect(full_html).to include('✗') # для неуспешного теста
    end
  end
end 