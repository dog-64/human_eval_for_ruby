# frozen_string_literal: true

require 'thor'
require 'fileutils'
require_relative 'runner'

module TestRunner
  class CLI < Thor
    package_name 'Test Runner'

    class_option :all,
                 type: :boolean,
                 default: false,
                 desc: 'Запуск всех тестов'

    class_option :task,
                 type: :string,
                 default: false,
                 desc: 'Запуск конкретного теста'

    class_option :log_level,
                 type: :string,
                 enum: %w[none normal debug],
                 default: 'normal',
                 desc: 'Уровень логирования'

    class_option :report,
                 type: :boolean,
                 default: true,
                 desc: 'Показать только сводный отчет по моделям'

    desc 'all', 'Запустить все тесты'
    def all
      runner = Runner.new(options)
      runner.run_all_tests
    end

    desc 'task TASK_NUMBER', 'Запустить тесты для конкретной задачи'
    def task(task_number)
      runner = Runner.new(options)
      runner.run_task_tests(task_number)
    end

    desc 'model TASK_NUMBER MODEL', 'Запустить тесты для конкретной задачи и модели'
    def model(task_number, model)
      runner = Runner.new(options)
      runner.run_model_tests(task_number, model)
    end

    def self.exit_on_failure?
      true
    end
  end
end
