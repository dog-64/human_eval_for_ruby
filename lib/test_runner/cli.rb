# frozen_string_literal: true

require 'thor'
require 'fileutils'
require_relative 'runner'

module TestRunner
  class CLI < Thor
    package_name 'Test Runner'

    desc 'all', 'Запустить все тесты'
    method_option :report_total, type: :boolean, default: true,
                  desc: 'Показывать только общий отчет'
    method_option :log_level, type: :string, default: 'normal',
                  desc: 'Уровень логирования (debug, normal, quiet)'
    def all
      runner = Runner.new(
        report_total: options[:report_total],
        log_level: (options[:log_level] || 'normal').to_sym
      )
      runner.run_all_tests
    end

    desc 'task TASK', 'Запустить тесты для конкретной задачи'
    method_option :report_total, type: :boolean, default: true,
                  desc: 'Показывать только общий отчет'
    method_option :log_level, type: :string, default: 'normal',
                  desc: 'Уровень логирования (debug, normal, quiet)'
    def task(task)
      runner = Runner.new(
        report_total: options[:report_total],
        log_level: (options[:log_level] || 'normal').to_sym
      )
      runner.run_task_tests(task)
    end

    desc 'model TASK MODEL', 'Запустить тесты для конкретной модели'
    method_option :report_total, type: :boolean, default: true,
                  desc: 'Показывать только общий отчет'
    method_option :log_level, type: :string, default: 'normal',
                  desc: 'Уровень логирования (debug, normal, quiet)'
    def model(task, model)
      runner = Runner.new(
        report_total: options[:report_total],
        log_level: (options[:log_level] || 'normal').to_sym
      )
      runner.run_model_tests(task, model)
    end

    def self.exit_on_failure?
      true
    end

    def self.start(given_args = ARGV, config = {})
      # Добавляем опцию --report-total по умолчанию только в production окружении
      unless ENV['RACK_ENV'] == 'test'
        given_args << "--report-total" unless given_args.any? { |arg| arg.include?("report-total") }
      end
      super
    end
  end
end
