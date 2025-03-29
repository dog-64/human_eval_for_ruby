require 'thor'
require 'fileutils'
require_relative 'runner'

module TestRunner
  class CLI < Thor
    package_name 'Test Runner'

    desc 'tests', 'Запустить тесты'

    class_option :task,
                 type: :string,
                 default: '',
                 desc: 'Запуск конкретного теста (например, T1, T2, T3)'

    class_option :model,
                 type: :string,
                 default: '',
                 desc: 'Запуск тестов для конкретной модели'

    class_option :log_level,
                 type: :string,
                 enum: %w[none normal debug],
                 default: 'normal',
                 desc: 'Уровень логирования'

    class_option :report,
                 type: :boolean,
                 default: true,
                 desc: 'Показать только сводный отчет по моделям'

    def tests
      runner = Runner.new(options)
      runner.run_tests(
        task: options[:task].to_s.empty? ? nil : options[:task],
        model: options[:model].to_s.empty? ? nil : options[:model]
      )
    end

    def self.exit_on_failure?
      true
    end
  end
end
