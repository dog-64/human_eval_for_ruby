require 'spec_helper'
require_relative '../lib/human_eval/report_generator'

RSpec.describe HumanEval::ReportGenerator do
  let(:test_reports_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:model_stats) { [['model1', 10, 10, 100], ['model2', 5, 10, 50]] }
  let(:task_results) { { 't1' => { 'model1' => true, 'model2' => false } } }
  let(:results) { { model_stats: model_stats, task_results: task_results } }
  let(:generator) { described_class.new(results, reports_dir: test_reports_dir) }

  before(:each) do
    FileUtils.mkdir_p(test_reports_dir)
  end

  after(:each) do
    FileUtils.rm_rf(test_reports_dir)
  end

  describe '#initialize' do
    it 'sets the correct instance variables' do
      expect(generator.instance_variable_get(:@results)).to eq(results)
      expect(generator.instance_variable_get(:@reports_dir)).to eq(test_reports_dir)
    end

    it 'creates the reports directory if it does not exist' do
      FileUtils.rm_rf(test_reports_dir)
      expect(Dir.exist?(test_reports_dir)).to be false
      described_class.new(results, reports_dir: test_reports_dir)
      expect(Dir.exist?(test_reports_dir)).to be true
    end

    it 'uses the default reports directory when none is provided' do
      allow(FileUtils).to receive(:mkdir_p).with('reports')
      generator = described_class.new(results)
      expect(generator.instance_variable_get(:@reports_dir)).to eq('reports')
    end
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
      expect(md_content).to include('model1: 10/10 (100%)')
      expect(md_content).to include('model2: 5/10 (50%)')
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
        expect(html).to include('<td>10</td>') # для модели 1
        expect(html).to include('<td>5</td>')  # для модели 2
      end

      # Проверяем специфичные элементы полного отчета
      expect(full_html).to include('Детальные результаты по задачам')
      expect(full_html).to include('t1')
      expect(full_html).to include('✓') # для успешного теста
      expect(full_html).to include('✗') # для неуспешного теста
    end

    it 'calls all report generation methods in the correct order' do
      expect(generator).to receive(:save_json).ordered
      expect(generator).to receive(:create_html_reports).ordered
      expect(generator).to receive(:create_markdown).ordered
      expect(generator).to receive(:update_readme).ordered
      
      generator.generate_all
    end
  end

  describe '#save_json' do
    it 'creates a JSON file with the correct content' do
      generator.send(:save_json)
      
      json_path = File.join(test_reports_dir, 'test_results.json')
      expect(File).to exist(json_path)
      
      json_content = JSON.parse(File.read(json_path))
      expect(json_content['models']).to eq(model_stats)
      expect(json_content['tasks']).to eq(task_results)
      expect(json_content).to have_key('timestamp')
    end
  end

  describe '#create_html_reports' do
    it 'calls the necessary methods to create HTML reports' do
      expect(generator).to receive(:generate_html_header).and_call_original
      expect(generator).to receive(:create_total_html).with(an_instance_of(String)).and_call_original
      expect(generator).to receive(:create_full_html).with(an_instance_of(String)).and_call_original
      
      generator.send(:create_html_reports)
    end
  end

  describe '#create_markdown' do
    it 'generates a markdown report with correct formatting' do
      generator.send(:create_markdown)
      
      md_path = File.join(test_reports_dir, 'total.md')
      expect(File).to exist(md_path)
      
      md_content = File.read(md_path)
      expect(md_content).to include('## Рейтинг')
      expect(md_content).to include('model1: 10/10 (100%)')
      expect(md_content).to include('model2: 5/10 (50%)')
    end
  end

  describe '#generate_html_header' do
    it 'returns HTML header with all necessary elements' do
      header = generator.send(:generate_html_header)
      
      expect(header).to include('<!DOCTYPE html>')
      expect(header).to include('<html lang="ru">')
      expect(header).to include('<meta charset="UTF-8">')
      expect(header).to include('<meta name="viewport"')
      expect(header).to include('<style>')
      expect(header).to include('body {')
      expect(header).to include('.success')
      expect(header).to include('.failure')
    end
  end
  
  describe '#add_soft_hyphens' do
    it 'adds soft hyphens to underscores' do
      expect(generator.send(:add_soft_hyphens, 'hello_world')).to eq('hello_&shy;world')
      expect(generator.send(:add_soft_hyphens, 'multi_part_name')).to eq('multi_&shy;part_&shy;name')
    end
    
    it 'returns original text when no underscores' do
      expect(generator.send(:add_soft_hyphens, 'hello')).to eq('hello')
    end
  end
  
  describe '#find_solution_files' do
    before do
      FileUtils.mkdir_p(File.join(test_reports_dir, 'solutions'))
      File.write(File.join(test_reports_dir, 'solutions', 'task1_solution.rb'), '# Task 1 Solution')
      File.write(File.join(test_reports_dir, 'solutions', 'task2_solution.rb'), '# Task 2 Solution')
    end
    
    it 'returns all solution files when no task is specified' do
      files = generator.send(:find_solution_files)
      expect(files.length).to eq(2)
      expect(files).to include(File.join(test_reports_dir, 'solutions', 'task1_solution.rb'))
      expect(files).to include(File.join(test_reports_dir, 'solutions', 'task2_solution.rb'))
    end
    
    it 'returns only the specified task solution when task is specified' do
      files = generator.send(:find_solution_files, 'task1')
      expect(files.length).to eq(1)
      expect(files).to include(File.join(test_reports_dir, 'solutions', 'task1_solution.rb'))
    end
    
    it 'returns empty array when no solution files exist' do
      FileUtils.rm_rf(File.join(test_reports_dir, 'solutions'))
      files = generator.send(:find_solution_files)
      expect(files).to be_empty
    end
  end

  describe '#create_total_html' do
    it 'creates a total HTML report with correct content' do
      html_header = generator.send(:generate_html_header)
      generator.send(:create_total_html, html_header)
      
      total_html_path = File.join(test_reports_dir, 'human_eval_for_ruby_report_total.html')
      expect(File).to exist(total_html_path)
      
      total_html = File.read(total_html_path)
      expect(total_html).to include('Суммарный отчет о тестировании моделей')
      expect(total_html).to include('<table>')
      expect(total_html).to include('<tr><th>Модель</th><th>Успешность</th><th>Пройдено</th><th>Всего</th></tr>')
      expect(total_html).to include('<td>model1</td><td>100%</td><td>10</td><td>10</td>')
      expect(total_html).to include('<td>model2</td><td>50%</td><td>5</td><td>10</td>')
    end
  end

  describe '#create_full_html' do
    it 'creates a full HTML report with correct content' do
      html_header = generator.send(:generate_html_header)
      generator.send(:create_full_html, html_header)
      
      full_html_path = File.join(test_reports_dir, 'human_eval_for_ruby_report_full.html')
      expect(File).to exist(full_html_path)
      
      full_html = File.read(full_html_path)
      expect(full_html).to include('Отчет о тестировании моделей')
      expect(full_html).to include('Результаты по моделям')
      expect(full_html).to include('Детальные результаты по задачам')
      expect(full_html).to include('<td>model1</td><td>100%</td><td>10</td><td>10</td>')
      expect(full_html).to include('<td>model2</td><td>50%</td><td>5</td><td>10</td>')
      expect(full_html).to include('t1')
      
      # Проверка правильного рендеринга результатов
      if task_results['t1']['model1']
        expect(full_html).to include("<td class='success'>✓</td>")
      else
        expect(full_html).to include("<td class='failure'>✗</td>")
      end
    end
  end

  describe '#update_readme' do
    # Вместо предыдущих тестов добавляем один надежный тест с реальными файловыми операциями
    let(:test_reports_dir) { File.join('spec', 'tmp', 'test_reports') }
    let(:test_results) { { model_stats: [['model1', 10, 10, 100], ['model2', 5, 10, 50]], task_results: {} } }
    let(:generator) { described_class.new(test_results, reports_dir: test_reports_dir) }
    let(:readme_path) { File.join(test_reports_dir, 'README.md') }
    let(:total_path) { File.join(test_reports_dir, 'total.md') }
    let(:readme_content) { "# Test\n\n## Рейтинг\nold_model: 0%\n\n## Other section\nsome content" }
    let(:total_content) { "## Рейтинг\n\n- model1: 10/10 (100%)\n- model2: 5/10 (50%)\n" }
      
    # Метод для подготовки директории для тестов
    def setup_test_directory
      FileUtils.rm_rf(test_reports_dir) if File.exist?(test_reports_dir)
      FileUtils.mkdir_p(test_reports_dir)
    end
    
    # Метод для очистки директории после тестов
    def cleanup_test_directory
      FileUtils.rm_rf(test_reports_dir) if File.exist?(test_reports_dir)
    end
    
    before(:each) do
      setup_test_directory
    end
    
    after(:each) do
      cleanup_test_directory
    end
    
    context 'при наличии обоих файлов' do
      it 'обновляет README.md с данными из total.md' do
        # Создаем тестовые файлы
        File.write(readme_path, readme_content)
        File.write(total_path, total_content)
        
        # Вызываем метод
        generator.send(:update_readme)
        
        # Проверяем результат
        updated_content = File.read(readme_path)
        expect(updated_content).to include("- model1: 10/10 (100%)")
        expect(updated_content).to include("- model2: 5/10 (50%)")
        expect(updated_content).not_to include("old_model: 0%")
      end
    end
    
    context 'когда README.md не существует' do
      it 'не делает ничего' do
        # Создаем только total.md
        File.write(total_path, total_content)
        
        # Вызываем метод
        generator.send(:update_readme)
        
        # Проверяем, что README.md не был создан
        expect(File.exist?(readme_path)).to be false
      end
    end
    
    context 'когда total.md не существует' do
      it 'не изменяет README.md' do
        # Создаем только README.md
        File.write(readme_path, readme_content)
        
        # Запоминаем исходное содержимое
        original_content = File.read(readme_path)
        
        # Вызываем метод
        generator.send(:update_readme)
        
        # Проверяем, что README.md не изменился
        updated_content = File.read(readme_path)
        expect(updated_content).to eq(original_content)
      end
    end
  end

  describe 'Регулярное выражение для update_readme' do
    it 'проверяет замену с регулярным выражением напрямую' do
      # Создаем тестовые данные в соответствии с реальными операциями в методе
      readme_content = "# Test\n\n## Рейтинг\nold_model: 0%\n\n## Other section\nsome content"
      total_content = "## Рейтинг\n\n- model1: 10/10 (100%)\n- model2: 5/10 (50%)\n"
      
      # Удаляем заголовок из total.md
      total_content_without_header = total_content.sub(/^## Рейтинг\s*\n+/, '')
      
      # Формируем новую секцию
      new_rating_section = "## Рейтинг\n\n#{total_content_without_header}"
      
      # Выполняем замену с использованием регулярного выражения
      new_readme_content = readme_content.sub(
        /## Рейтинг.*?(?=\n##|\z)/m,
        new_rating_section.chomp
      )
      
      # Для отладки
      puts "Original README: #{readme_content.inspect}"
      puts "New Rating Section: #{new_rating_section.inspect}"
      puts "Updated README: #{new_readme_content.inspect}"
      
      # Проверяем, что контент изменился
      expect(new_readme_content).not_to eq(readme_content)
      expect(new_readme_content).to include("- model1: 10/10 (100%)")
      expect(new_readme_content).to include("- model2: 5/10 (50%)")
      expect(new_readme_content).not_to include("old_model: 0%")
    end
  end
end
