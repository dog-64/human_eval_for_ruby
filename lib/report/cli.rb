require 'thor'
require_relative 'runner'

module Report
  # CLI для генерации отчетов
  class CLI < Thor
    package_name 'Report'

    desc 'generate', 'Генерация отчетов о результатах тестирования'
    method_option :results_file,
                  type: :string,
                  desc: 'Путь к файлу с результатами тестирования (JSON)',
                  default: 'reports/test_results.json'
    method_option :output_dir,
                  type: :string,
                  desc: 'Директория для сохранения отчетов',
                  default: 'reports'

    def generate
      options_hash = {
        results_file: options[:results_file],
        output_dir: options[:output_dir]
      }

      runner = Runner.new(options_hash)
      result = runner.generate
      exit(1) unless result
      result
    end

    default_task :generate

    # Определяет поведение при ошибке выполнения команды
    def self.exit_on_failure?
      true
    end
  end
end 