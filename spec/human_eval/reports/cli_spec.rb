# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe HumanEval::Reports::CLI do
  let(:output_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:results_file) { File.join('spec', 'fixtures', 'results.json') }
  let(:total_report) { File.join(output_dir, 'human_eval_for_ruby_report_total.html') }
  let(:full_report) { File.join(output_dir, 'human_eval_for_ruby_report_full.html') }
  let(:style_file) { File.join(output_dir, 'style.css') }
  
  before(:each) do
    FileUtils.mkdir_p(output_dir)
    FileUtils.mkdir_p(File.dirname(results_file))
    
    # Создаем тестовый файл с результатами
    File.write(results_file, {
      'results' => {
        't1' => { 'model1' => true, 'model2' => false },
        't2' => { 'model1' => false, 'model2' => true }
      }
    }.to_json)

    # Перехватываем STDOUT для тестирования вывода
    @original_stdout = $stdout
    @stdout = StringIO.new
    $stdout = @stdout
  end

  after(:each) do
    FileUtils.rm_rf(output_dir)
    FileUtils.rm_f(results_file)
    # Восстанавливаем оригинальный STDOUT
    $stdout = @original_stdout
  end

  describe '#generate' do
    let(:cli) { described_class.new }

    context 'когда генерация проходит успешно' do
      it 'генерирует HTML отчеты и выводит сообщение об успехе' do
        cli.invoke(:generate, [], {
          output_dir: output_dir,
          results_file: results_file,
          format: 'html'
        })

        expect(@stdout.string).to include("Отчеты сгенерированы в директории: #{output_dir}")
        expect(@stdout.string).to include("Формат: html")
        
        expect(File.exist?(total_report)).to be true
        expect(File.exist?(full_report)).to be true
        expect(File.exist?(style_file)).to be true
      end

      it 'использует HTML формат по умолчанию' do
        cli.invoke(:generate, [], {
          output_dir: output_dir,
          results_file: results_file
        })

        expect(File.exist?(total_report)).to be true
        expect(File.exist?(full_report)).to be true
        expect(File.exist?(style_file)).to be true
      end
    end

    context 'когда возникают ошибки' do
      it 'выводит сообщение об ошибке при некорректном формате' do
        expect {
          cli.invoke(:generate, [], {
            output_dir: output_dir,
            results_file: results_file,
            format: 'invalid'
          })
        }.to raise_error(SystemExit)

        expect(@stdout.string).to include('Неподдерживаемый формат')
      end

      it 'выводит сообщение об ошибке при отсутствии файла с результатами' do
        expect {
          cli.invoke(:generate, [], {
            output_dir: output_dir,
            results_file: 'non_existent.json',
            format: 'html'
          })
        }.to raise_error(SystemExit)

        expect(@stdout.string).to include('не существует')
      end

      it 'выводит сообщение об ошибке при некорректном JSON' do
        File.write(results_file, 'invalid json')

        expect {
          cli.invoke(:generate, [], {
            output_dir: output_dir,
            results_file: results_file,
            format: 'html'
          })
        }.to raise_error(SystemExit)

        expect(@stdout.string).to include('Ошибка при чтении файла результатов')
      end
    end
  end

  describe '#say_error' do
    let(:cli) { described_class.new }
    let(:error_message) { 'Тестовая ошибка' }

    it 'выводит сообщение об ошибке в правильном формате' do
      cli.send(:say_error, error_message)
      expect(@stdout.string).to include("Error: #{error_message}")
    end
  end
end 