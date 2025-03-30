require 'spec_helper'
require_relative '../../lib/report/runner'

RSpec.describe Report::Runner do
  let(:test_dir) { 'spec/tmp/report_runner' }
  let(:results_file) { File.join(test_dir, 'test_results.json') }
  let(:model_stats) { [['model1', 10, 10, 100], ['model2', 5, 10, 50]] }
  let(:task_results) {
    {
      't1' => { 'model1' => true, 'model2' => false },
      't2' => { 'model1' => true, 'model2' => true }
    }
  }
  let(:options) { { output_dir: test_dir, results_file: results_file } }
  let(:runner) { described_class.new(options) }

  before do
    FileUtils.rm_rf(test_dir)
    FileUtils.mkdir_p(test_dir)
  end

  after do
    FileUtils.rm_rf(test_dir)
  end

  describe '#generate' do
    context 'when results file exists' do
      before do
        # Создаем тестовый файл с результатами
        File.write(results_file, JSON.generate({
          'models' => model_stats,
          'tasks' => task_results,
          'timestamp' => Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }))
      end

      it 'generates reports successfully' do
        # Проверяем, что Generator#generate_all вызывается с правильными параметрами
        generator = instance_double(Report::Generator)
        expect(Report::Generator).to receive(:new)
          .with({ model_stats: model_stats, task_results: task_results }, reports_dir: test_dir)
          .and_return(generator)
        expect(generator).to receive(:generate_all)
        
        # Подавляем вывод сообщения о создании отчетов
        expect(runner).to receive(:puts).with(/Отчеты успешно созданы/)

        expect(runner.generate).to be true
      end
    end

    context 'when results file does not exist' do
      it 'returns false and displays error message' do
        expect(runner).to receive(:puts).with(/Файл с результатами не найден/)
        expect(runner).to receive(:puts).with(/Сначала запустите тесты/)
        
        expect(runner.generate).to be false
      end
    end

    context 'when results file has invalid JSON' do
      before do
        File.write(results_file, 'invalid json')
      end

      it 'returns false and displays error message' do
        expect(runner).to receive(:puts).with(/Ошибка при чтении файла с результатами/)
        
        expect(runner.generate).to be false
      end
    end

    context 'when generator raises an error' do
      before do
        File.write(results_file, JSON.generate({
          'models' => model_stats,
          'tasks' => task_results
        }))
      end

      it 'returns false and displays error message' do
        generator = instance_double(Report::Generator)
        expect(Report::Generator).to receive(:new).and_return(generator)
        expect(generator).to receive(:generate_all).and_raise(StandardError.new('Test error'))
        
        expect(runner).to receive(:puts).with(/Ошибка при генерации отчетов: Test error/)
        
        expect(runner.generate).to be false
      end
    end
  end

  describe 'private methods' do
    describe '#ensure_output_directory' do
      it 'creates output directory if it does not exist' do
        new_dir = File.join(test_dir, 'new_dir')
        options = { output_dir: new_dir }
        runner = described_class.new(options)
        
        expect(Dir.exist?(new_dir)).to be false
        runner.send(:ensure_output_directory)
        expect(Dir.exist?(new_dir)).to be true
      end
    end

    describe '#load_results' do
      it 'loads and transforms results from JSON file' do
        File.write(results_file, JSON.generate({
          'models' => model_stats,
          'tasks' => task_results
        }))
        
        results = runner.send(:load_results, results_file)
        
        expect(results[:model_stats]).to eq(model_stats)
        expect(results[:task_results]).to eq(task_results)
      end
    end
  end
end 