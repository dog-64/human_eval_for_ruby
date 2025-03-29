require 'thor'
require 'fileutils'
require_relative 'solver/help'
require_relative 'solver'

module HumanEval
  # обработка командной строки решателя заданий
  class SolverCLI < Thor
    include HumanEval::Solver::Help
    package_name 'Human Eval Solver'

    # Показывать справку, если команда не указана
    def self.start(given_args = ARGV, config = {})
      given_args = ['commands'] if given_args.empty?
      super
    end

    desc 'solve TASKS_DIR', 'Solve tasks from TASKS_DIR using AI models'
    method_option :model,
                  type: :string,
                  desc: "Use specific model (используйте 'commands' для просмотра списка моделей)"
    method_option :task,
                  type: :string,
                  desc: 'Решить конкретную задачу (можно указать как номер, так и имя, например: 1 или t1)'
    method_option :log_level,
                  type: :string,
                  enum: %w[none normal debug],
                  default: 'normal',
                  desc: 'Logging level'
    method_option :keep_existing,
                  type: :boolean,
                  default: false,
                  desc: 'Keep existing solutions'

    def solve(tasks_dir)
      options_hash = {
        model: options[:model],
        task: options[:task],
        log_level: options[:log_level],
        keep_existing: options[:keep_existing]
      }

      solver = SolverClass.new(tasks_dir, options_hash)
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
