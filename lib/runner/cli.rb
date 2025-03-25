# frozen_string_literal: true

require 'thor'
require 'fileutils'
require_relative './runner'

module Runner
  class CLI < Thor
    package_name 'Test Runner'

    class Error < Thor::Error; end

    LOG_LEVELS = {
      'debug' => :debug,
      'normal' => :normal,
      'error' => :error
    }

    class_option :log_level,
                 type: :string,
                 default: 'normal',
                 desc: 'Уровень логирования (debug, normal, error)'

    class_option :generate_reports,
                 type: :boolean,
                 default: true,
                 desc: 'Генерировать отчеты'

    desc 'all', 'Запустить все тесты'
    def all
      puts "Debug: CLI options = #{options.inspect}"
      runner = Runner.new(
        log_level: LOG_LEVELS[options[:log_level]],
        generate_reports: options[:generate_reports]
      )
      puts "Debug: Runner options = #{runner.instance_variable_get(:@options).inspect}"
      runner.run_all_tests
    end

    desc 'model MODEL', 'Запустить тесты для конкретной модели'
    def model(model_name)
      validate_argument('model', model_name)
      runner = Runner.new(
        log_level: LOG_LEVELS[options[:log_level]],
        generate_reports: false
      )
      runner.run_model_tests(nil, model_name)
    end

    desc 'task TASK', 'Запустить тесты для конкретного задания'
    def task(task_name)
      validate_argument('task', task_name)
      runner = Runner.new(
        log_level: LOG_LEVELS[options[:log_level]],
        generate_reports: false
      )
      runner.run_task_tests(task_name)
    end

    def self.exit_on_failure?
      true
    end

    def self.start(given_args = ARGV, config = {})
      # Преобразуем аргументы с дефисами в правильный формат
      args = []
      i = 0
      while i < given_args.length
        arg = given_args[i]
        case arg
        when '--task'
          validate_next_argument('--task', given_args, i)
          args.push('task', given_args[i + 1])
          i += 2
        when '--model'
          validate_next_argument('--model', given_args, i)
          args.push('model', given_args[i + 1])
          i += 2
        when '--all'
          args.push('all')
          i += 1
        else
          args.push(arg)
          i += 1
        end
      end
      super(args, config)
    rescue Error => e
      puts "\e[31mОшибка: #{e.message}\e[0m"
      exit(1)
    end

    private

    def self.validate_next_argument(key, args, index)
      if index + 1 >= args.length || args[index + 1].start_with?('--')
        raise Error, "Не указано значение для ключа #{key}"
      end
    end

    def validate_argument(type, value)
      case type
      when 'task'
        unless value.to_s.match?(/^t\d+$/)
          raise Error, "Неверный формат задания. Ожидается формат 't<число>' (например, 't1')"
        end
      when 'model'
        unless value.to_s.match?(/^[a-zA-Z0-9_-]+$/)
          raise Error, 'Неверный формат названия модели'
        end
      end
    end
  end
end
