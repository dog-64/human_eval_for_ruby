require 'thor'
require_relative 'human_eval_solver'

module HumanEval
  class SolverCLI < Thor
    package_name "Human Eval Solver"

    # Показывать справку, если команда не указана
    def self.start(given_args=ARGV, config={})
      if given_args.empty?
        given_args = ["commands"]
      end
      super(given_args, config)
    end

    desc "solve TASKS_DIR", "Solve tasks from TASKS_DIR using AI models"
    method_option :model,
                 type: :string,
                 desc: "Use specific model (#{Solver::MODELS.keys.join(', ')})"
    method_option :task,
                 type: :string,
                 desc: "Решить конкретную задачу (можно указать как номер, так и имя, например: 1 или t1)"
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

      solver = Solver.new(tasks_dir, options_hash)
      solver.process
    end

    desc "commands", "Показать все доступные команды и опции"
    def commands
      puts "Доступные команды Human Eval Solver:"
      puts

      # Вывод команд
      puts "== Команды =="
      puts "solve TASKS_DIR: Solve tasks from TASKS_DIR using AI models"
      puts "  Опции:"
      puts "    --model=MODEL: Use specific model"
      puts "    --task=TASK: Решить конкретную задачу (можно указать как номер, так и имя, например: 1 или t1)"
      puts "    --log-level=LOG_LEVEL: Logging level (по умолчанию: normal)"
      puts "      Возможные значения: none, normal, debug"
      puts "    --keep-existing: Keep existing solutions (по умолчанию: false)"
      puts
      puts "commands: Показать все доступные команды и опции"
      puts
      puts "help [COMMAND]: Describe available commands or one specific command"
      puts

      # Вывод доступных моделей
      puts "== Доступные модели =="
      puts "OpenRouter.ai модели:"
      Solver::MODELS.select { |_, info| info[:provider] == 'openrouter.ai' }.each do |key, info|
        note = info[:note] ? " (#{info[:note]})" : ""
        puts "  #{key}: #{info[:name]}#{note}"
      end
      
      puts "\nЛокальные Ollama модели:"
      Solver::MODELS.select { |_, info| info[:provider] == 'ollama' }.each do |key, info|
        note = info[:note] ? " (#{info[:note]})" : ""
        puts "  #{key}: #{info[:name]}#{note}"
      end
      
      # Вывод примеров использования
      puts "\n== Примеры использования =="
      puts "# Решение всех задач конкретной моделью"
      puts "./bin/human_eval_solver solve tasks --model \"MODEL_NAME\""
      puts
      puts "# Решение конкретной задачи"
      puts "./bin/human_eval_solver solve tasks --task t1 --model \"MODEL_NAME\""
      puts "# или"
      puts "./bin/human_eval_solver solve tasks --task 1 --model \"MODEL_NAME\""
      puts
      puts "# Сохранение промежуточных результатов"
      puts "./bin/human_eval_solver solve tasks --model \"MODEL_NAME\" --keep-existing"
      puts
      puts "# Включение подробного логирования"
      puts "./bin/human_eval_solver solve tasks --model \"MODEL_NAME\" --log-level debug"
    end

    def self.exit_on_failure?
      true
    end
  end
end 
