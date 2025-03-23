require 'thor'
require_relative 'human_eval/solver'

module HumanEval
  class SolverCLI < Thor
    package_name "Human Eval Solver"

    desc "solve TASKS_DIR", "Solve tasks from TASKS_DIR using AI models"
    method_option :model,
                 type: :string,
                 desc: "Use specific model (#{SolverClass::MODELS.keys.join(', ')})"
    method_option :task,
                 type: :string,
                 desc: "Solve specific task number"
    method_option :log_level,
                 type: :string,
                 enum: %w[none normal debug],
                 default: "normal",
                 desc: "Logging level"
    method_option :keep_existing,
                 type: :boolean,
                 default: false,
                 desc: "Keep existing solutions"

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

    def self.exit_on_failure?
      true
    end
  end
end 
