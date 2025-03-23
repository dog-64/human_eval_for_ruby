# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/human_eval/report_generator'

RSpec.describe HumanEval::ReportGenerator do
  let(:test_reports_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:model_stats) { { 'model1' => 100, 'model2' => 50 } }
  let(:task_results) { { 't1' => { 'model1' => true, 'model2' => false } } }
  let(:results) { { model_stats: model_stats, task_results: task_results } }
  let(:generator) { described_class.new(results, reports_dir: test_reports_dir) }

  before(:each) do
    FileUtils.mkdir_p(test_reports_dir)
    
    # Мокаем методы работы с README.md
    allow_any_instance_of(HumanEval::ReportGenerator).to receive(:update_readme)
  end

  after(:each) do
    FileUtils.remove_entry(test_reports_dir) if Dir.exist?(test_reports_dir)
  end

  describe '#generate_all' do
    it 'creates all report files' do
      generator.generate_all

      expect(File).to exist(File.join(test_reports_dir, 'test_results.json'))
      expect(File).to exist(File.join(test_reports_dir, 'human_eval_for_ruby_report_total.html'))
      expect(File).to exist(File.join(test_reports_dir, 'human_eval_for_ruby_report_full.html'))
      expect(File).to exist(File.join(test_reports_dir, 'total.md'))
    end

    it 'generates correct JSON report' do
      generator.generate_all
      json_content = JSON.parse(File.read(File.join(test_reports_dir, 'test_results.json')))

      expect(json_content['models']).to eq(model_stats)
      expect(json_content['tasks']).to eq(task_results)
      expect(json_content).to have_key('timestamp')
    end

    it 'generates correct markdown report' do
      generator.generate_all
      md_content = File.read(File.join(test_reports_dir, 'total.md'))

      expect(md_content).to include('## Рейтинг')
      expect(md_content).to include('model1: 100%')
      expect(md_content).to include('model2: 50%')
    end

    it 'generates HTML reports with correct content' do
      generator.generate_all
      total_html = File.read(File.join(test_reports_dir, 'human_eval_for_ruby_report_total.html'))
      full_html = File.read(File.join(test_reports_dir, 'human_eval_for_ruby_report_full.html'))

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

  describe '#update_readme' do
    let(:test_reports_dir) { Dir.mktmpdir('test_reports_') }
    let(:test_results) { { model_stats: { 'model1' => 100, 'model2' => 50 }, task_results: {} } }
    let(:generator) { described_class.new(test_results, reports_dir: test_reports_dir) }
    let(:readme_path) { File.join(test_reports_dir, 'README.md') }
    let(:total_path) { File.join(test_reports_dir, 'total.md') }

    before do
      FileUtils.mkdir_p(test_reports_dir)
      File.write(readme_path, "# Test\n\n## Рейтинг\nold_model: 0%\n\n## Other section\nsome content")
      File.write(total_path, "model1: 100%\nmodel2: 50%")
      
      allow(File).to receive(:exist?).with(readme_path).and_return(true)
      allow(File).to receive(:exist?).with(total_path).and_return(true)
      allow(File).to receive(:read).with(any_args) do |path|
        if path == readme_path
          File.read(readme_path)
        elsif path == total_path
          File.read(total_path)
        end
      end
      allow(File).to receive(:write).with(any_args) do |path, content|
        if path == readme_path
          expect(content).to include("model1: 100%")
          expect(content).to include("model2: 50%")
          expect(content).not_to include("old_model: 0%")
          expect(content).to include("## Рейтинг")
        end
      end
    end

    after do
      FileUtils.remove_entry(test_reports_dir)
    end

    it 'updates rating section in README.md' do
      generator.generate_all
    end
  end
end 