require_relative '../models'

module Solver
  # Модуль Help предоставляет методы для отображения справочной информации
  # о командах и опциях Solver
  module Help
    def show
      base
      models
      examples
    end

    private

    # Отображает примеры использования команд
    def examples
      puts "\n== Примеры использования =="
      show_solve_examples
      show_additional_examples
    end

    # Отображает примеры использования команды solve
    def show_solve_examples
      puts '# Решение всех задач конкретной моделью'
      puts './bin/solver solve tasks --model "MODEL_NAME"'
      puts
      puts '# Решение конкретной задачи'
      puts './bin/solver solve tasks --task t1 --model "MODEL_NAME"'
      puts '# или'
      puts './bin/solver solve tasks --task 1 --model "MODEL_NAME"'
    end

    # Отображает дополнительные примеры использования
    def show_additional_examples
      puts
      puts '# Сохранение промежуточных результатов'
      puts './bin/solver solve tasks --model "MODEL_NAME" --keep-existing'
      puts
      puts '# Включение подробного логирования'
      puts './bin/solver solve tasks --model "MODEL_NAME" --log-level debug'
      puts
      puts '# Создание пустых файлов при таймаутах или ошибках'
      puts './bin/solver solve tasks --model "MODEL_NAME" --create-empty-on-timeout'
    end

    # Отображает список доступных моделей
    def models
      puts '== Доступные модели =='
      show_openrouter_models
      show_ollama_models
    end

    # Отображает список моделей OpenRouter.ai
    def show_openrouter_models
      puts 'OpenRouter.ai модели:'
      models_manager = Models.new
      models_manager.all.select { |_, info| info['provider'] == 'openrouter.ai' }.each do |key, info|
        note = info['note'] ? " (#{info['note']})" : ''
        puts "  #{key}: #{info['name']}#{note}"
      end
    end

    # Отображает список локальных моделей Ollama
    def show_ollama_models
      puts "\nЛокальные Ollama модели:"
      models_manager = Models.new
      models_manager.all.select { |_, info| info['provider'] == 'ollama' }.each do |key, info|
        note = info['note'] ? " (#{info['note']})" : ''
        puts "  #{key}: #{info['name']}#{note}"
      end
    end

    # Отображает базовую информацию о командах
    def base
      puts 'Доступные команды Solver:'
      puts
      show_commands
    end

    # Отображает список доступных команд и их опций
    def show_commands
      puts '== Команды =='
      puts 'solve TASKS_DIR: Solve tasks from TASKS_DIR using AI models'
      show_solve_options
      puts
      puts 'commands: Показать все доступные команды и опции'
      puts
      puts 'help [COMMAND]: Describe available commands or one specific command'
      puts
    end

    # Отображает опции команды solve
    def show_solve_options
      puts '  Опции:'
      puts '    --model=MODEL: Use specific model'
      puts '    --task=TASK: Решить конкретную задачу (можно указать как номер, так и имя, например: 1 или t1)'
      puts '    --log-level=LOG_LEVEL: Logging level (по умолчанию: normal)'
      puts '      Возможные значения: none, normal, debug'
      puts '    --keep-existing: Keep existing solutions (по умолчанию: false)'
      puts '    --create-empty-on-timeout: Создавать пустой файл решения с комментарием при таймауте или ошибке (по умолчанию: false)'
    end
  end
end 