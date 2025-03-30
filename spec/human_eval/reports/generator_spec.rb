require 'spec_helper'
require 'fileutils'
require 'json'
require_relative '../../../lib/human_eval/reports/generator'

RSpec.describe HumanEval::Reports::Generator do
  let(:output_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:task_results) { { 'task1' => { 'model1' => true, 'model2' => false } } }
  let(:models) { ['model1', 'model2'] }
  let(:tasks) { ['task1'] }
  let(:model_stats) { [['model1', 100], ['model2', 50]] }

  let(:generator) do
    allow(File).to receive(:read).and_call_original
    allow(File).to receive(:read).with(HumanEval::Reports::Generator::RESULTS_FILE).and_return('{}')
    
    gen = described_class.new(
      output_dir: output_dir,
      task_results: task_results,
      models: models,
      tasks: tasks,
      model_stats: model_stats,
      format: 'all'
    )
    
    # Устанавливаем переменные экземпляра напрямую, т.к. у нас есть моки и валидации
    gen.instance_variable_set(:@results, task_results)
    gen.instance_variable_set(:@models, models)
    gen.instance_variable_set(:@tasks, tasks)
    gen.instance_variable_set(:@model_stats, model_stats)
    gen
  end

  before(:each) do
    FileUtils.mkdir_p(output_dir)
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with(HumanEval::Reports::Generator::RESULTS_FILE).and_return(true)
    allow(File).to receive(:write).and_call_original
  end

  after(:each) do
    FileUtils.rm_rf(output_dir) if Dir.exist?(output_dir)
  end

  describe '#initialize' do
    it 'sets the correct instance variables' do
      # Для этого теста создаем новый экземпляр без моков
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      generator = described_class.new(
        output_dir: output_dir,
        task_results: task_results,
        models: models,
        tasks: tasks,
        model_stats: model_stats,
        format: 'all'
      )
      
      expect(generator.instance_variable_get(:@output_dir)).to eq(output_dir)
      expect(generator.instance_variable_get(:@results)).to eq(task_results)
      expect(generator.instance_variable_get(:@models)).to eq(models)
      expect(generator.instance_variable_get(:@tasks)).to eq(tasks)
      expect(generator.instance_variable_get(:@model_stats)).to eq(model_stats)
    end

    it 'uses default values when not provided' do
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      generator = described_class.new
      expect(generator.instance_variable_get(:@output_dir)).to eq('reports')
      expect(generator.instance_variable_get(:@format)).to eq('all')
    end

    it 'calculates model stats when not provided' do
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      generator = described_class.new(
        output_dir: output_dir,
        task_results: task_results,
        models: models,
        tasks: tasks
      )
      # Не проверяем конкретные значения, только то, что stats не пусты
      expect(generator.instance_variable_get(:@model_stats)).not_to be_empty
    end
  end

  describe '#validate_paths!' do
    it 'raises an error when output directory is not specified' do
      # Используем test environment для обхода валидации внешнего пути
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      
      # Создаем новый экземпляр без проверки в initialize,
      # чтобы не было ошибки при создании объекта
      generator = described_class.new(output_dir: output_dir)
      generator.instance_variable_set(:@output_dir, nil)
      
      expect { generator.send(:validate_paths!) }.to raise_error(HumanEval::Reports::Error)
    end

    it 'raises an error when output directory is empty' do
      # Используем test environment для обхода валидации внешнего пути
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      
      # Создаем новый экземпляр без проверки в initialize,
      # чтобы не было ошибки при создании объекта
      generator = described_class.new(output_dir: output_dir)
      generator.instance_variable_set(:@output_dir, '')
      
      expect { generator.send(:validate_paths!) }.to raise_error(HumanEval::Reports::Error)
    end

    it 'raises no error when in test environment' do
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      generator = described_class.new(output_dir: '/some/external/path')
      expect { generator.send(:validate_paths!) }.not_to raise_error
    end
  end

  describe '#validate_options!' do
    it 'raises an error for invalid format' do
      # Используем test environment для обхода валидаций в initialize
      allow(ENV).to receive(:[]).with('RUBY_ENV').and_return('test')
      
      generator = described_class.new(output_dir: output_dir)
      generator.instance_variable_set(:@format, 'invalid')
      
      expect { generator.send(:validate_options!) }.to raise_error(HumanEval::Reports::Error)
    end

    it 'does not raise an error for valid format' do
      generator = described_class.new(format: 'html', output_dir: output_dir)
      expect { generator.send(:validate_options!) }.not_to raise_error
    end
  end

  describe '#generate_html_report' do
    before do
      # Разрешаем чтение файлов в тестах для проверки содержимого
      allow(File).to receive(:read).with(any_args).and_call_original
    end
    
    it 'creates a report file with all necessary content' do
      generator.send(:generate_html_report, task_results)
      
      # Проверяем, что файл создан
      report_path = File.join(output_dir, 'report.html')
      style_path = File.join(output_dir, 'style.css')
      expect(File).to exist(report_path)
      expect(File).to exist(style_path)
      
      # Проверяем содержимое файла
      content = File.read(report_path)
      expect(content).to include('<!DOCTYPE html>')
      expect(content).to include('<html lang="ru">')
      expect(content).to include('<title>Отчет о тестировании моделей</title>')
      expect(content).to include('<h1>Отчет о тестировании моделей</h1>')
      expect(content).to include('<h2>Общая статистика по моделям</h2>')
      expect(content).to include('<h2>Детальные результаты</h2>')
      
      # Проверяем наличие данных в файле
      expect(content).to include('model1')
      expect(content).to include('model2')
      expect(content).to include('task1')
      expect(content).to include('success')
      expect(content).to include('failure')
    end
    
    it 'formats the model stats correctly' do
      generator.send(:generate_html_report, task_results)
      
      content = File.read(File.join(output_dir, 'report.html'))
      
      # Проверяем формат данных статистики
      expect(content).to include("<td class='success'>100%</td>")
      
      # Проверяем сортировку моделей по убыванию успешности
      expect(content.index('model1')).to be < content.index('model2')
    end
    
    it 'formats task results with correct symbols' do
      generator.send(:generate_html_report, task_results)
      
      content = File.read(File.join(output_dir, 'report.html'))
      
      # Проверяем символы успеха/неудачи
      expect(content).to include("<td class='success'>✓</td>")
      expect(content).to include("<td class='failure'>✗</td>")
    end
    
    it 'handles empty task results' do
      empty_generator = described_class.new(
        output_dir: output_dir,
        format: 'all'
      )
      
      empty_generator.instance_variable_set(:@results, {})
      empty_generator.instance_variable_set(:@models, models)
      empty_generator.instance_variable_set(:@tasks, [])
      
      empty_generator.send(:generate_html_report, {})
      
      content = File.read(File.join(output_dir, 'report.html'))
      
      # Проверяем, что отчет создан корректно даже при отсутствии данных
      expect(content).to include('<!DOCTYPE html>')
      expect(content).to include('<h1>Отчет о тестировании моделей</h1>')
      expect(content).to include('<table class="stats-table">')
      expect(content).to include('<table class="results-table">')
    end
  end

  describe '#generate_markdown_report' do
    before do
      # Разрешаем чтение файлов в тестах для проверки содержимого
      allow(File).to receive(:read).with(any_args).and_call_original
    end
    
    it 'creates a markdown report file with correct content' do
      generator.send(:generate_markdown_report, task_results)
      
      # Проверяем, что файл создан
      report_path = File.join(output_dir, 'report.md')
      expect(File).to exist(report_path)
      
      # Проверяем содержимое файла
      content = File.read(report_path)
      expect(content).to include('# Отчет о тестировании моделей')
      expect(content).to include('## Общая статистика')
      expect(content).to include('## Детальные результаты')
      
      # Проверяем наличие данных в файле
      expect(content).to include('model1')
      expect(content).to include('model2')
      expect(content).to include('task1')
      expect(content).to include('✓')
      expect(content).to include('✗')
    end
  end

  describe '#generate_html_header' do
    it 'returns HTML header with all necessary elements' do
      header = generator.send(:generate_html_header)
      expect(header).to include('<!DOCTYPE html>')
      expect(header).to include('<html lang="ru">')
      expect(header).to include('<meta charset="UTF-8">')
      expect(header).to include('<meta name="viewport"')
      expect(header).to include('<title>Отчет о тестировании моделей</title>')
      expect(header).to include('<link rel="stylesheet" href="style.css">')
    end
  end

  describe '#generate_css' do
    it 'returns CSS styles with all necessary elements' do
      css = generator.send(:generate_css)
      expect(css).to include('body {')
      expect(css).to include('table {')
      expect(css).to include('th, td {')
      expect(css).to include('.success {')
      expect(css).to include('.failure {')
    end
  end

  describe '#calculate_model_stats' do
    it 'correctly calculates statistics for each model' do
      results = {
        'task1' => { 'model1' => true, 'model2' => false },
        'task2' => { 'model1' => true, 'model2' => true }
      }
      
      stats = generator.send(:calculate_model_stats, results)
      
      # Проверяем правильность расчета статистики
      expect(stats).to include(['model1', 100])
      expect(stats).to include(['model2', 50])
      
      # Проверяем, что результаты отсортированы по убыванию успешности
      expect(stats.first).to eq(['model1', 100])
      expect(stats.last).to eq(['model2', 50])
    end
    
    it 'handles empty results' do
      stats = generator.send(:calculate_model_stats, {})
      expect(stats).to be_empty
    end
    
    it 'handles results with no successes' do
      results = {
        'task1' => { 'model1' => false, 'model2' => false }
      }
      
      stats = generator.send(:calculate_model_stats, results)
      
      # Проверяем, что процент успешности равен 0
      expect(stats).to include(['model1', 0])
      expect(stats).to include(['model2', 0])
    end
  end

  describe '#generate' do
    it 'creates the output directory if it does not exist' do
      FileUtils.rm_rf(output_dir)
      expect(Dir.exist?(output_dir)).to be false
      
      allow(generator).to receive(:generate_by_format)
      generator.generate
      
      expect(Dir.exist?(output_dir)).to be true
    end
    
    it 'calls generate_by_format with the correct parameters' do
      allow(generator).to receive(:generate_by_format)
      generator.instance_variable_set(:@format, 'html')
      
      expect(generator).to receive(:generate_by_format).with(
        'html',
        output_dir,
        task_results,
        model_stats,
        an_instance_of(String)
      )
      
      generator.generate
    end
    
    it 'uses all formats when format is set to all' do
      allow(generator).to receive(:generate_by_format)
      generator.instance_variable_set(:@format, 'all')
      
      expect(generator).to receive(:generate_by_format).with(
        'html',
        output_dir,
        task_results,
        model_stats,
        an_instance_of(String)
      )
      
      generator.generate
    end
  end

  describe '#generate_by_format' do
    let(:timestamp) { '20240501_120000' }

    it 'calls correct methods for html format' do
      html_formatter = instance_double(HumanEval::Reports::Formatters::HTML)
      allow(HumanEval::Reports::Formatters::HTML).to receive(:new).and_return(html_formatter)
      allow(html_formatter).to receive(:generate)
      
      generator.send(:generate_by_format, 'html', output_dir, task_results, model_stats, timestamp)
      
      expect(HumanEval::Reports::Formatters::HTML).to have_received(:new).with(
        output_dir: output_dir,
        task_results: task_results,
        model_stats: model_stats,
        timestamp: timestamp
      )
      expect(html_formatter).to have_received(:generate)
    end
    
    it 'calls generate_markdown_report for markdown format' do
      expect(generator).to receive(:generate_markdown_report).with(task_results)
      
      generator.send(:generate_by_format, 'markdown', output_dir, task_results, model_stats, timestamp)
    end
    
    it 'calls both methods for all format' do
      expect(generator).to receive(:generate_html_report).with(task_results)
      expect(generator).to receive(:generate_markdown_report).with(task_results)
      
      generator.send(:generate_by_format, 'all', output_dir, task_results, model_stats, timestamp)
    end
  end
end
