require 'spec_helper'
require 'fileutils'
require_relative '../../../../lib/human_eval/reports/formatters/html'

RSpec.describe HumanEval::Reports::Formatters::HTML do
  let(:output_dir) { 'spec/tmp/test_reports' }
  let(:model_stats) { [['model1', 100], ['model2', 50]] }
  let(:task_results) { { 'task1' => { 'model1' => true, 'model2' => false } } }
  let(:timestamp) { '20240501_120000' }
  let(:formatter) { described_class.new(output_dir: output_dir, task_results: task_results, model_stats: model_stats, timestamp: timestamp) }

  before do
    FileUtils.mkdir_p(output_dir)
  end

  after do
    FileUtils.rm_rf(output_dir) if Dir.exist?(output_dir)
  end

  describe '#initialize' do
    it 'sets the correct instance variables' do
      expect(formatter.instance_variable_get(:@output_dir)).to eq(output_dir)
      expect(formatter.instance_variable_get(:@task_results)).to eq(task_results)
      expect(formatter.instance_variable_get(:@model_stats)).to eq(model_stats)
      expect(formatter.instance_variable_get(:@timestamp)).to eq(timestamp)
    end

    it 'defaults timestamp to current time if not provided' do
      allow(Time).to receive(:now).and_return(Time.parse('2024-05-01 12:00:00'))
      formatter_without_timestamp = described_class.new(output_dir: output_dir, task_results: task_results, model_stats: model_stats)
      expect(formatter_without_timestamp.instance_variable_get(:@timestamp)).to eq('20240501_120000')
    end
  end

  describe '#generate' do
    it 'creates the directory if it does not exist' do
      FileUtils.rm_rf(output_dir)
      expect(Dir.exist?(output_dir)).to be false
      formatter.generate
      expect(Dir.exist?(output_dir)).to be true
    end

    it 'generates all necessary files' do
      formatter.generate
      expect(File).to exist(File.join(output_dir, 'human_eval_for_ruby_report_total.html'))
      expect(File).to exist(File.join(output_dir, 'human_eval_for_ruby_report_full.html'))
      expect(File).to exist(File.join(output_dir, 'style.css'))
    end

    it 'calls the correct methods' do
      expect(formatter).to receive(:generate_total_report).once
      expect(formatter).to receive(:generate_full_report).once
      expect(formatter).to receive(:generate_styles).once
      formatter.generate
    end
  end

  describe '#generate_total_report' do
    it 'creates a total report file with correct content' do
      formatter.send(:generate_total_report)
      
      # Проверяем, что файл создан
      total_report_path = File.join(output_dir, 'human_eval_for_ruby_report_total.html')
      expect(File).to exist(total_report_path)
      
      # Проверяем содержимое файла
      content = File.read(total_report_path)
      expect(content).to include('<!DOCTYPE html>')
      expect(content).to include('<html lang="ru">')
      expect(content).to include('<h1>Суммарный отчет о тестировании моделей</h1>')
      expect(content).to include("<p>Дата: #{timestamp}</p>")
      expect(content).to include('model1')
      expect(content).to include('100%')
      expect(content).to include('model2')
      expect(content).to include('50%')
    end
  end

  describe '#generate_full_report' do
    it 'creates a full report file with correct content' do
      formatter.send(:generate_full_report)
      
      # Проверяем, что файл создан
      full_report_path = File.join(output_dir, 'human_eval_for_ruby_report_full.html')
      expect(File).to exist(full_report_path)
      
      # Проверяем содержимое файла
      content = File.read(full_report_path)
      expect(content).to include('<!DOCTYPE html>')
      expect(content).to include('<html lang="ru">')
      expect(content).to include('<h1>Полный отчет о тестировании моделей</h1>')
      expect(content).to include("<p>Дата: #{timestamp}</p>")
      expect(content).to include('model1')
      expect(content).to include('100%')
      expect(content).to include('model2')
      expect(content).to include('50%')
      expect(content).to include('task1')
      expect(content).to include('success')
      expect(content).to include('failure')
    end
  end

  describe '#generate_styles' do
    it 'creates a CSS file with correct content' do
      formatter.send(:generate_styles)
      
      # Проверяем, что файл создан
      css_path = File.join(output_dir, 'style.css')
      expect(File).to exist(css_path)
      
      # Проверяем содержимое файла
      content = File.read(css_path)
      expect(content).to include('body {')
      expect(content).to include('font-family')
      expect(content).to include('.success')
      expect(content).to include('.failure')
    end
  end

  describe '#html_header' do
    it 'returns HTML header with all necessary elements' do
      header = formatter.send(:html_header)
      expect(header).to include('<!DOCTYPE html>')
      expect(header).to include('<html lang="ru">')
      expect(header).to include('<meta charset="UTF-8">')
      expect(header).to include('<meta name="viewport"')
      expect(header).to include('<title>Отчет о тестировании моделей</title>')
      expect(header).to include('<link rel="stylesheet" href="style.css">')
    end
  end

  describe '#css_styles' do
    it 'returns CSS styles with all necessary elements' do
      styles = formatter.send(:css_styles)
      expect(styles).to include('body {')
      expect(styles).to include('table {')
      expect(styles).to include('th, td {')
      expect(styles).to include('.success')
      expect(styles).to include('.failure')
    end
  end

  describe '#generate_model_stats_table' do
    it 'generates a model stats table with correct content' do
      table = formatter.send(:generate_model_stats_table)
      expect(table).to include('<div class=\'model-results\'><table>')
      expect(table).to include('<tr><th>Модель</th><th>Успешность</th></tr>')
      expect(table).to include('<tr><td>model1</td><td>100%</td></tr>')
      expect(table).to include('<tr><td>model2</td><td>50%</td></tr>')
    end

    it 'handles empty model stats' do
      empty_formatter = described_class.new(output_dir: output_dir, task_results: task_results, model_stats: [])
      table = empty_formatter.send(:generate_model_stats_table)
      expect(table).to include('<div class=\'model-results\'><table>')
      expect(table).to include('<tr><th>Модель</th><th>Успешность</th></tr>')
      expect(table).not_to include('<tr><td>')
    end
  end

  describe '#generate_task_results_table' do
    it 'generates a task results table with correct content' do
      table = formatter.send(:generate_task_results_table)
      expect(table).to include('<div class=\'task-results\'><table>')
      expect(table).to include('<tr><th>Задача</th>')
      expect(table).to include('<th>model1</th>')
      expect(table).to include('<th>model2</th>')
      expect(table).to include('<tr><td>task1</td>')
      expect(table).to include("<td class='success'>")
      expect(table).to include("<td class='failure'>")
    end

    it 'handles empty task results' do
      empty_formatter = described_class.new(output_dir: output_dir, task_results: {}, model_stats: model_stats)
      table = empty_formatter.send(:generate_task_results_table)
      expect(table).to include('<div class=\'task-results\'><table>')
      expect(table).to include('<tr><th>Задача</th>')
      expect(table).not_to include('<tr><td>')
    end
  end

  describe '#percentage_color' do
    it 'returns correct color for high percentage' do
      expect(formatter.send(:percentage_color, 95)).to eq('success')
      expect(formatter.send(:percentage_color, 90)).to eq('success')
    end

    it 'returns correct color for medium percentage' do
      expect(formatter.send(:percentage_color, 80)).to eq('warning')
      expect(formatter.send(:percentage_color, 70)).to eq('warning')
    end

    it 'returns correct color for low percentage' do
      expect(formatter.send(:percentage_color, 60)).to eq('danger')
      expect(formatter.send(:percentage_color, 30)).to eq('danger')
      expect(formatter.send(:percentage_color, 0)).to eq('danger')
    end
  end

  describe '#format_percentage' do
    it 'formats percentage correctly' do
      expect(formatter.send(:format_percentage, 75)).to eq('75%')
      expect(formatter.send(:format_percentage, 0)).to eq('0%')
      expect(formatter.send(:format_percentage, 100)).to eq('100%')
    end
  end

  describe '#result_mark' do
    it 'returns correct mark for true result' do
      expect(formatter.send(:result_mark, true)).to eq('✓')
    end

    it 'returns correct mark for false result' do
      expect(formatter.send(:result_mark, false)).to eq('✗')
    end
  end

  describe '#result_class' do
    it 'returns correct class for true result' do
      expect(formatter.send(:result_class, true)).to eq('success')
    end

    it 'returns correct class for false result' do
      expect(formatter.send(:result_class, false)).to eq('danger')
    end
  end
end
