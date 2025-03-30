require 'thor'
require 'fileutils'
require_relative 'help'
require_relative 'runner'

module Solver
  # обработка командной строки решателя заданий
  class CLI < Thor
    include Solver::Help
    package_name 'Solver'

    # Показывать справку, если команда не указана
    def self.start(given_args = ARGV, config = {})
      given_args = ['commands'] if given_args.empty?
      super
    end

    default_task 'solve'
    desc 'solve TASKS_DIR', 'Решение задач из директории TASKS_DIR с помощью моделей LLM'
    method_option :model,
                  type: :string,
                  desc: "Используйте 'models' для просмотра списка моделей)"
    method_option :task,
                  type: :string,
                  desc: 'Решить конкретную задачу (можно указать как номер, так и имя, например: 1 или t1)'
    method_option :log_level,
                  type: :string,
                  enum: %w[none normal debug],
                  default: 'normal',
                  desc: 'Уровень логирования'
    method_option :keep_existing,
                  type: :boolean,
                  default: false,
                  desc: 'Сохранять существующие решения'
    method_option :create_empty_on_timeout,
                  type: :boolean,
                  default: false,
                  desc: 'Создавать пустой файл решения с комментарием при таймауте или ошибке'

    def solve(tasks_dir)
      options_hash = {
        model: options[:model],
        task: options[:task],
        log_level: options[:log_level],
        keep_existing: options[:keep_existing],
        create_empty_on_timeout: options[:create_empty_on_timeout]
      }

      solver = Runner.new(tasks_dir, options_hash)
      solver.process
    end

    desc 'commands', 'Показать все доступные команды и опции'
    def commands
      show
    end

    def self.exit_on_failure?
      true
    end
  end
end 