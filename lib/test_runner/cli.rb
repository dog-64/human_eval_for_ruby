require 'thor'
require 'fileutils'
require_relative 'runner'

module TestRunner
  # Класс CLI предоставляет интерфейс командной строки для запуска тестов
  # Построен на базе Thor и позволяет запускать тесты для конкретных задач и моделей,
  # управлять уровнем логирования и генерацией отчетов
  class CLI < Thor
    package_name 'Test Runner'

    desc 'tests', 'Запустить тесты'
    default_task :tests

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

    # Запускает тесты с заданными параметрами командной строки
    # Использует основной класс Runner для запуска тестов
    # и обработки результатов
    def tests
      runner = Runner.new(options)
      runner.run_tests(
        task: options[:task].to_s.empty? ? nil : options[:task],
        model: options[:model].to_s.empty? ? nil : options[:model]
      )
    end

    # Определяет поведение при ошибке выполнения команды
    # @return [Boolean] true - выход при ошибке, false - продолжение выполнения
    def self.exit_on_failure?
      true
    end
  end
end
