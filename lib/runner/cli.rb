require 'thor'
require 'fileutils'
require_relative 'runner'
require_relative '../model/to_path'
require_relative '../models'

module Runner
  # Класс CLI предоставляет интерфейс командной строки для запуска тестов
  # Построен на базе Thor и позволяет запускать тесты для конкретных задач и моделей,
  # управлять уровнем логирования и генерацией отчетов
  class CLI < Thor
    package_name 'Test Runner'

    desc 'execute', 'Запуск тестов для решений задач'
    method_option :task,
                  type: :string,
                  aliases: '-t',
                  desc: 'Задача для тестирования (например, t1)'
    method_option :model,
                  type: :string,
                  aliases: '-m',
                  desc: 'Модель для тестирования (например, deepseek/deepseek-chat:free или deepseek_deepseek_chat_free)'
    method_option :report,
                  type: :boolean,
                  aliases: '-r',
                  default: false,
                  desc: 'Сгенерировать отчет'
    method_option :log_level,
                  type: :string,
                  aliases: '-l',
                  enum: %w[none normal debug],
                  default: 'normal',
                  desc: 'Уровень логирования'

    def execute
      options_hash = {
        report: options[:report] || false,
        log_level: options[:log_level] ? options[:log_level].to_sym : :normal
      }
      
      runner = Runner.new(options_hash)
      
      # Проверяем формат модели
      if options[:model] && (options[:model].include?('/') || options[:model].include?(':') || options[:model].include?('-'))
        # Если передано оригинальное имя модели, используем его как есть
        runner.run_tests(task: options[:task], model: options[:model])
      else
        # Иначе используем как ключ модели
        runner.run_tests(task: options[:task], model: options[:model])
      end
    end

    desc 'list_models', 'Показать список доступных моделей'
    def list_models
      models_manager = Models.new
      puts "Доступные модели:"
      
      puts "\nOpenRouter.ai модели:"
      models_manager.all.select { |_, info| info['provider'] == 'openrouter.ai' }.each do |key, info|
        done_mark = info['done'] ? " ✓" : ""
        puts "  #{key}: #{info['name']}#{done_mark}"
      end
      
      puts "\nOllama модели:"
      models_manager.all.select { |_, info| info['provider'] == 'ollama' }.each do |key, info|
        done_mark = info['done'] ? " ✓" : ""
        puts "  #{key}: #{info['name']}#{done_mark}"
      end
    end

    default_task :execute

    # Определяет поведение при ошибке выполнения команды
    # @return [Boolean] true - выход при ошибке, false - продолжение выполнения
    def self.exit_on_failure?
      true
    end
  end
end
