# frozen_string_literal: true

require 'thor'
require_relative '../test_runner'

module TestRunner
  class CLI < Thor
    # Показывать справку, если команда не указана
    def self.start(given_args = ARGV, config = {})
      given_args = ['help'] if given_args.empty?
      super
    end

    class_option :log_level,
                 type: :string,
                 default: 'normal',
                 desc: 'Уровень логирования (debug, normal, error, none)',
                 aliases: '-l'

    class_option :report_total,
                 type: :boolean,
                 default: false,
                 desc: 'Показать только сводный отчет по моделям'

    desc 'all', 'Запустить все тесты'
    def all
      runner = Runner.new(options)
      runner.run_all_tests
    end

    desc 'task TASK', 'Запустить тесты для конкретной задачи'
    def task(task_id)
      runner = Runner.new(options)
      runner.run_task_tests(task_id)
    end

    desc 'model TASK MODEL', 'Запустить тесты для конкретной задачи и модели'
    def model(task_id, model_name)
      runner = Runner.new(options)
      runner.run_model_tests(task_id, model_name)
    end

    desc 'commands', 'Показать все доступные команды и опции'
    def commands
      puts 'Доступные команды Test Runner:'
      puts

      # Вывод команд
      puts '== Команды =='
      puts 'all: Запустить все тесты'
      puts '  Опции:'
      puts '    --log-level=LOG_LEVEL: Уровень логирования (по умолчанию: normal)'
      puts '      Возможные значения: none, normal, debug'
      puts '    --report-total: Показать только сводный отчет по моделям (по умолчанию: false)'
      puts
      puts 'task TASK_NUMBER: Запустить тесты для конкретной задачи'
      puts '  Опции: те же, что и для команды all'
      puts
      puts 'model TASK_NUMBER MODEL: Запустить тесты для конкретной задачи и модели'
      puts '  Опции: те же, что и для команды all'
      puts
      puts 'commands: Показать все доступные команды и опции'
      puts
      puts 'help [COMMAND]: Describe available commands or one specific command'
      puts

      # Вывод примеров использования
      puts "\n== Примеры использования =="
      puts '# Запуск всех тестов'
      puts './bin/run_tests all'
      puts
      puts '# Запуск тестов для конкретной задачи'
      puts './bin/run_tests task t1'
      puts
      puts '# Запуск тестов для конкретной задачи и модели'
      puts './bin/run_tests model t1 ollama_llama3_2'
      puts
      puts '# Запуск с подробным логированием'
      puts './bin/run_tests task t1 --log-level debug'
      puts
      puts '# Запуск с выводом только сводного отчета'
      puts './bin/run_tests all --report-total'
    end

    def self.exit_on_failure?
      true
    end
  end
end
