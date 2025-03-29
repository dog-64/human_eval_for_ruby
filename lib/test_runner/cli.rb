# frozen_string_literal: true

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
      if !options[:task].to_s.empty? && !options[:model].to_s.empty?
        runner.run_model_tests(options[:task], options[:model])
      elsif !options[:task].to_s.empty?
        runner.run_task_tests(options[:task])
      elsif !options[:model].to_s.empty?
        runner.run_model_tests('', options[:model])
      else
        runner.run_all_tests
      end
    end

    def self.exit_on_failure?
      true
    end
  end
end
