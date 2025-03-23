# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe HumanEval::Reports::CLI do
  let(:output_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:default_options) do
    {
      format: 'all',
      output_dir: 'reports'
    }
  end
  let(:custom_options) do
    {
      format: 'html',
      output_dir: output_dir
    }
  end

  before(:each) do
    FileUtils.mkdir_p(output_dir)
    # Перехватываем STDOUT для тестирования вывода
    @original_stdout = $stdout
    @stdout = StringIO.new
    $stdout = @stdout
  end

  after(:each) do
    FileUtils.rm_rf(output_dir)
    # Восстанавливаем оригинальный STDOUT
    $stdout = @original_stdout
  end

  describe '#initialize' do
    it 'использует значения по умолчанию, если опции не указаны' do
      cli = described_class.new
      expect(cli.instance_variable_get(:@options)).to eq(default_options)
    end

    it 'объединяет пользовательские опции с опциями по умолчанию' do
      cli = described_class.new(custom_options)
      expect(cli.instance_variable_get(:@options)).to eq(default_options.merge(custom_options))
    end
  end

  describe '#generate' do
    let(:generator) { instance_double(HumanEval::Reports::Generator) }
    let(:cli) { described_class.new(custom_options) }

    context 'когда генерация проходит успешно' do
      before do
        allow(HumanEval::Reports::Generator).to receive(:new).and_return(generator)
        allow(generator).to receive(:generate)
      end

      it 'создает генератор с правильными опциями' do
        expect(HumanEval::Reports::Generator).to receive(:new).with(custom_options)
        cli.generate
      end

      it 'вызывает generate у генератора' do
        expect(generator).to receive(:generate)
        cli.generate
      end
    end

    context 'когда возникает ошибка' do
      let(:error_message) { 'Тестовая ошибка' }

      before do
        allow(HumanEval::Reports::Generator).to receive(:new).and_return(generator)
        allow(generator).to receive(:generate).and_raise(HumanEval::Reports::Error, error_message)
      end

      it 'выводит сообщение об ошибке' do
        expect { cli.generate }.to raise_error(SystemExit)
        expect(@stdout.string).to include("Ошибка при генерации отчета: #{error_message}")
      end

      it 'завершает программу с кодом 1' do
        expect { cli.generate }.to raise_error(SystemExit) do |error|
          expect(error.status).to eq(1)
        end
      end
    end
  end

  describe '#display_total' do
    let(:cli) { described_class.new }
    let(:results) do
      {
        model_stats: {
          'model1' => 75,
          'model2' => 50,
          'model3' => 25
        }
      }
    end

    it 'выводит результаты в правильном формате' do
      cli.send(:display_total, results)
      output = @stdout.string

      expect(output).to include('Результаты тестирования моделей:')
      expect(output).to include('model1: 75%')
      expect(output).to include('model2: 50%')
      expect(output).to include('model3: 25%')
    end

    it 'сортирует результаты по убыванию процентов' do
      cli.send(:display_total, results)
      output = @stdout.string.split("\n")
      
      model_lines = output.select { |line| line.start_with?('- ') }
      percentages = model_lines.map { |line| line[/(\d+)%/, 1].to_i }
      expect(percentages).to eq([75, 50, 25])
    end

    it 'не вызывает ошибку при пустых результатах' do
      expect { cli.send(:display_total, nil) }.not_to raise_error
      expect { cli.send(:display_total, {}) }.not_to raise_error
      expect { cli.send(:display_total, { model_stats: {} }) }.not_to raise_error
    end
  end

  describe '#say_error' do
    let(:cli) { described_class.new }
    let(:error_message) { 'Тестовая ошибка' }

    it 'выводит сообщение об ошибке в правильном формате' do
      shell = cli.instance_variable_get(:@shell)
      expect(shell).to receive(:say).with("Error: #{error_message}", :red)
      cli.send(:say_error, error_message)
    end
  end
end 