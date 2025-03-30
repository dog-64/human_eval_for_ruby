require 'spec_helper'
require 'open3'

RSpec.describe 'bin/report_helper' do
  it 'запускается и возвращает код 0 для команды help' do
    stdout, stderr, status = Open3.capture3('bundle exec bin/report_helper help')

    expect(status.exitstatus).to eq(0)
    expect(stdout).to include('Report commands:')
    expect(stdout).to include('report generate')
    expect(stderr).to be_empty
  end

  it 'показывает имя команды как "report" вместо "report_helper"' do
    stdout, = Open3.capture3('bundle exec bin/report_helper help')

    expect(stdout).to include('report generate')
    expect(stdout).not_to include('report_helper generate')
  end

  it 'запускает генерацию отчетов при вызове команды generate' do
    # Подготовка директории для теста
    test_dir = 'spec/tmp/test_report_helper'
    FileUtils.rm_rf(test_dir)
    FileUtils.mkdir_p(test_dir)

    # Создаем тестовый results.json
    test_results = {
      'timestamp' => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
      'models' => [['test_model', 2, 3, 67]],
      'tasks' => { 't1' => { 'test_model' => true } }
    }
    File.write(File.join(test_dir, 'test_results.json'), JSON.generate(test_results))

    # Запускаем команду
    stdout, stderr, status = Open3.capture3(
      "bundle exec bin/report_helper generate --results-file=#{test_dir}/test_results.json --output-dir=#{test_dir}"
    )

    begin
      expect(status.exitstatus).to eq(0)
      expect(stdout).to include('Отчеты успешно созданы')
      expect(stderr).to be_empty

      # Проверяем, что файлы отчетов созданы
      expect(File.exist?(File.join(test_dir, 'human_eval_for_ruby_report_total.html'))).to be true
      expect(File.exist?(File.join(test_dir, 'human_eval_for_ruby_report_full.html'))).to be true
      expect(File.exist?(File.join(test_dir, 'total.md'))).to be true
    ensure
      # Удаляем временные файлы
      FileUtils.rm_rf(test_dir)
    end
  end
end
