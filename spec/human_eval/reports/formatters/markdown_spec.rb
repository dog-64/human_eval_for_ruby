# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'

RSpec.describe HumanEval::Reports::Formatters::Markdown do
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
    context 'когда генерируется общий отчет' do
      before do
        formatter.generate
      end

      it 'создает файл total.md' do
        expect(File.exist?(File.join(output_dir, 'total.md'))).to be true
      end

      it 'содержит правильный заголовок' do
        content = File.read(File.join(output_dir, 'total.md'))
        expect(content).to include('## Рейтинг')
      end

      it 'содержит статистику по моделям' do
        content = File.read(File.join(output_dir, 'total.md'))
        model_stats.each do |model, percentage|
          expect(content).to include("- #{model}: #{percentage}%")
        end
      end
    end

    context 'когда обновляется README.md' do
      let(:readme_content) do
        <<~README
          # Тестовый проект

          ## Рейтинг
          old_model: 0%

          ## Другой раздел
          Какой-то контент
        README
      end

      before do
        File.write(File.join(output_dir, 'README.md'), readme_content)
        formatter.generate
      end

      it 'обновляет секцию рейтинга в README.md' do
        content = File.read(File.join(output_dir, 'README.md'))
        expect(content).to include('## Рейтинг')
        model_stats.each do |model, percentage|
          expect(content).to include("- #{model}: #{percentage}%")
        end
        expect(content).not_to include('old_model: 0%')
        expect(content).to include('## Другой раздел')
        expect(content).to include('Какой-то контент')
      end

      it 'сохраняет остальное содержимое README.md без изменений' do
        content = File.read(File.join(output_dir, 'README.md'))
        expect(content).to include('# Тестовый проект')
        expect(content).to include('## Другой раздел')
        expect(content).to include('Какой-то контент')
      end
    end

    context 'когда README.md не существует' do
      it 'не вызывает ошибку' do
        expect { formatter.generate }.not_to raise_error
      end

      it 'создает только total.md' do
        formatter.generate
        expect(File.exist?(File.join(output_dir, 'total.md'))).to be true
        expect(File.exist?(File.join(output_dir, 'README.md'))).to be false
      end
    end
  end
end 