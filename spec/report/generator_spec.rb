require 'spec_helper'
require_relative '../../lib/report/generator'

RSpec.describe Report::Generator do
  let(:test_dir) { 'spec/tmp/reports' }
  let(:model_stats) { [['model1', 10, 10, 100], ['model2', 5, 10, 50]] }
  let(:task_results) do
    {
      't1' => { 'model1' => true, 'model2' => false },
      't2' => { 'model1' => true, 'model2' => true }
    }
  end
  let(:results) { { model_stats: model_stats, task_results: task_results } }
  let(:generator) { described_class.new(results, reports_dir: test_dir) }

  before do
    FileUtils.rm_rf(test_dir)
    FileUtils.mkdir_p(test_dir)
  end

  after do
    FileUtils.rm_rf(test_dir)
  end

  describe '#generate_all' do
    it 'creates all report files' do
      generator.generate_all

      expect(File.exist?(File.join(test_dir, 'test_results.json'))).to be true
      expect(File.exist?(File.join(test_dir, 'human_eval_for_ruby_report_total.html'))).to be true
      expect(File.exist?(File.join(test_dir, 'human_eval_for_ruby_report_full.html'))).to be true
      expect(File.exist?(File.join(test_dir, 'total.md'))).to be true
    end
  end

  describe 'private methods' do
    describe '#save_json' do
      it 'saves results to a JSON file' do
        generator.send(:save_json)
        json_path = File.join(test_dir, 'test_results.json')

        expect(File.exist?(json_path)).to be true

        json_data = JSON.parse(File.read(json_path))
        expect(json_data['models']).to eq(model_stats)
        expect(json_data['tasks']).to eq(task_results)
      end
    end

    describe '#create_markdown' do
      it 'creates a markdown report' do
        generator.send(:create_markdown)
        markdown_path = File.join(test_dir, 'total.md')

        expect(File.exist?(markdown_path)).to be true

        content = File.read(markdown_path)
        expect(content).to include('## Рейтинг')
        expect(content).to include('model1: 10/10 (100%)')
        expect(content).to include('model2: 5/10 (50%)')
      end
    end

    describe '#update_readme' do
      it 'updates the README with new ratings' do
        # Создаем файлы для теста
        File.write(File.join(test_dir, 'README.md'),
                   "# Test\n\n## Рейтинг\nold_model: 0%\n\n## Other section\nsome content")
        generator.send(:create_markdown)

        generator.send(:update_readme)

        readme_content = File.read(File.join(test_dir, 'README.md'))
        expect(readme_content).to include('model1: 10/10 (100%)')
        expect(readme_content).to include('model2: 5/10 (50%)')
        expect(readme_content).not_to include('old_model: 0%')
        expect(readme_content).to include('## Other section')
      end
    end

    describe '#create_total_html' do
      it 'creates a total HTML report' do
        css = 'body { color: #333; }'
        allow(generator).to receive(:load_css).and_return(css)
        # Устанавливаем фиксированную дату для стабильности тестов
        fixed_time = Time.new(2025, 3, 30, 12, 0, 0)
        allow(Time).to receive(:now).and_return(fixed_time)

        generator.send(:create_total_html, css)

        html_path = File.join(test_dir, 'human_eval_for_ruby_report_total.html')
        expect(File.exist?(html_path)).to be true

        content = File.read(html_path)
        expect(content).to include('<h1>Суммарный отчет о тестировании моделей</h1>')
        expect(content).to include('<td>model1</td>')
        expect(content).to include('<td>100%</td>')
        expect(content).to include('<td>10</td>')
        expect(content).to include('body { color: #333; }')
      end
    end

    describe '#create_full_html' do
      it 'creates a full HTML report' do
        css = 'body { color: #333; }'
        allow(generator).to receive(:load_css).and_return(css)
        # Устанавливаем фиксированную дату для стабильности тестов
        fixed_time = Time.new(2025, 3, 30, 12, 0, 0)
        allow(Time).to receive(:now).and_return(fixed_time)

        generator.send(:create_full_html, css)

        html_path = File.join(test_dir, 'human_eval_for_ruby_report_full.html')
        expect(File.exist?(html_path)).to be true

        content = File.read(html_path)
        expect(content).to include('<h1>Отчет о тестировании моделей</h1>')
        expect(content).to include('<h2>Результаты по моделям</h2>')
        expect(content).to include('<h2>Детальные результаты по задачам</h2>')
        expect(content).to include('<th>Задача</th>')
        expect(content).to include('<td>t1</td>')
        expect(content).to include('<td class=\'success\'>✓</td>')
        expect(content).to include('<td class=\'failure\'>✗</td>')
        expect(content).to include('body { color: #333; }')
      end
    end

    describe '#load_css' do
      it 'loads CSS from file' do
        # Подменяем чтение файла с помощью mock
        css_path = File.join(Report::Generator::TEMPLATES_DIR, 'css', 'report.css')
        allow(File).to receive(:read).with(css_path).and_return('body { color: #333; }')

        css = generator.send(:load_css)
        expect(css).to eq('body { color: #333; }')
      end
    end
  end
end
