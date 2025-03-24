# frozen_string_literal: true

require 'thor'
require 'fileutils'
require_relative 'runner'

module Runner
  class CLI < Thor
    package_name 'Test Runner'

    LOG_LEVELS = {
      'debug' => :debug,
      'normal' => :normal,
      'error' => :error
    }

    class_option :log_level,
                 type: :string,
                 enum: LOG_LEVELS.keys,
                 default: 'normal',
                 desc: 'Уровень логирования'

    class_option :timeout,
                 type: :numeric,
                 default: 5,
                 desc: 'Таймаут выполнения теста в секундах'

    desc 'all', 'Запустить все тесты'
    def all
      runner = TestRunner::Runner.new(
        log_level: LOG_LEVELS[options[:log_level]],
        timeout: options[:timeout]
      )
      runner.run_all_tests
    end

    desc 'model MODEL', 'Запустить тесты для конкретной модели'
    def model(model_name)
      runner = TestRunner::Runner.new(
        log_level: LOG_LEVELS[options[:log_level]],
        timeout: options[:timeout]
      )
      runner.run_model_tests(nil, model_name)
    end

    desc 'task TASK', 'Запустить тесты для конкретного задания'
    def task(task_name)
      runner = TestRunner::Runner.new(
        log_level: LOG_LEVELS[options[:log_level]],
        timeout: options[:timeout]
      )
      runner.run_task_tests(task_name)
    end

    def self.exit_on_failure?
      true
    end

    def self.start(given_args = ARGV, config = {})
      super
    end
  end
end
