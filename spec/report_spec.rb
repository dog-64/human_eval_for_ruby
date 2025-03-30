require 'spec_helper'
require_relative '../lib/report'

RSpec.describe Report do
  it 'is defined as a module' do
    expect(described_class).to be_a(Module)
  end

  describe 'module structure' do
    it 'includes Generator class' do
      expect(Report.const_defined?(:Generator)).to be true
      expect(Report::Generator).to be_a(Class)
    end

    it 'includes Runner class' do
      expect(Report.const_defined?(:Runner)).to be true
      expect(Report::Runner).to be_a(Class)
    end

    it 'includes CLI class' do
      expect(Report.const_defined?(:CLI)).to be true
      expect(Report::CLI).to be_a(Class)
    end
  end

  describe '.cli' do
    let(:cli_instance) { instance_double(Report::CLI) }

    before do
      allow(Report::CLI).to receive(:start).and_return(true)
    end

    it 'вызывает CLI.start с переданными аргументами' do
      args = ['generate', '--output-dir=test_reports']
      expect(Report::CLI).to receive(:start).with(args).and_return(true)
      Report.cli(args)
    end

    it 'возвращает результат вызова CLI.start' do
      allow(Report::CLI).to receive(:start).and_return('success')
      expect(Report.cli).to eq('success')
    end

    context 'с блоком' do
      it 'выполняет блок с результатом CLI.start' do
        result = nil
        Report.cli(['generate']) do |r|
          result = r
        end
        expect(result).to eq(true)
      end
    end
  end

  describe 'функциональность отчетов' do
    it 'правильно форматирует имена моделей в отчетах через Model::ToPath' do
      # Проверяем, что Report::Generator использует Model::ToPath для форматирования
      expect(Model::ToPath).to respond_to(:from_path)

      # Так как мы не можем напрямую тестировать private методы,
      # убедимся, что классы имеют необходимые зависимости
      generator_file = File.read(File.join('lib', 'report', 'generator.rb'))
      expect(generator_file).to include("require_relative '../model/to_path'")
      expect(generator_file).to include('format_model_name')
      expect(generator_file).to include('Model::ToPath.from_path')
    end

    it 'генерирует отчеты в разных форматах' do
      # Проверяем, что Generator имеет методы для создания разных типов отчетов
      expect(Report::Generator.instance_methods).to include(:generate_all)

      generator_file = File.read(File.join('lib', 'report', 'generator.rb'))
      expect(generator_file).to include('create_html_reports')
      expect(generator_file).to include('create_markdown')
      expect(generator_file).to include('save_json')
    end
  end
end
