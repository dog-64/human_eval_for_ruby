require 'spec_helper'
require 'fileutils'
require 'json'

RSpec.describe HumanEval::Reports do
  let(:test_reports_dir) { File.join('spec', 'tmp', 'test_reports') }
  let(:test_results_file) { File.join('spec', 'fixtures', 'results.json') }
  let(:test_results) do
    {
      'results' => {
        't1' => { 'model1' => true, 'model2' => false },
        't2' => { 'model1' => false, 'model2' => true }
      }
    }
  end

  before(:each) do
    FileUtils.mkdir_p(test_reports_dir)
    FileUtils.mkdir_p(File.dirname(test_results_file))
    File.write(test_results_file, test_results.to_json)
  end

  after(:each) do
    FileUtils.rm_rf(test_reports_dir)
    FileUtils.rm_f(test_results_file)
  end

  describe '.generate_reports' do
    context 'безопасность файловых операций' do
      let(:unsafe_paths) do
        [
          '../unsafe_path',
          '/tmp/unsafe_path',
          '../../unsafe_path'
        ]
      end

      it 'не позволяет генерировать отчеты за пределами spec' do
        unsafe_paths.each do |unsafe_path|
          expect do
            described_class.generate_reports(
              results_file: test_results_file,
              output_dir: unsafe_path,
              format: 'html'
            )
          end.to raise_error(ArgumentError, /должен находиться внутри каталога spec/)
        end
      end

      it 'не позволяет читать файл с результатами за пределами spec' do
        unsafe_paths.each do |unsafe_path|
          expect do
            described_class.generate_reports(
              results_file: unsafe_path,
              output_dir: test_reports_dir,
              format: 'html'
            )
          end.to raise_error(ArgumentError, /должен находиться внутри каталога spec/)
        end
      end
    end

    context 'генерация отчетов' do
      it 'создает отчеты в указанной директории' do
        described_class.generate_reports(
          results_file: test_results_file,
          output_dir: test_reports_dir,
          format: 'html'
        )

        expect(File.exist?(File.join(test_reports_dir, 'human_eval_for_ruby_report_total.html'))).to be true
        expect(File.exist?(File.join(test_reports_dir, 'human_eval_for_ruby_report_full.html'))).to be true
        expect(File.exist?(File.join(test_reports_dir, 'style.css'))).to be true
      end
    end

    context 'обработка ошибок' do
      it 'вызывает ошибку при отсутствии файла с результатами' do
        expect do
          described_class.generate_reports(
            results_file: 'spec/fixtures/non_existent.json',
            output_dir: test_reports_dir,
            format: 'html'
          )
        end.to raise_error(ArgumentError, /не существует/)
      end

      it 'вызывает ошибку при некорректном JSON в файле результатов' do
        File.write(test_results_file, 'invalid json')

        expect do
          described_class.generate_reports(
            results_file: test_results_file,
            output_dir: test_reports_dir,
            format: 'html'
          )
        end.to raise_error(JSON::ParserError)
      end

      it 'вызывает ошибку при неподдерживаемом формате' do
        expect do
          described_class.generate_reports(
            results_file: test_results_file,
            output_dir: test_reports_dir,
            format: 'invalid'
          )
        end.to raise_error(ArgumentError, /Неподдерживаемый формат/)
      end
    end
  end
end
