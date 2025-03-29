require 'thor'
require 'fileutils'
require_relative 'converter'

module HumanEval
  # Класс CLI предоставляет интерфейс командной строки для работы с инструментом Human Eval
  # Основан на Thor и позволяет конвертировать задачи из формата human-eval в отдельные файлы,
  # управлять параметрами конвертации и логированием
  class CLI < Thor
    package_name 'Human Eval Converter'
    class_option :help, aliases: '-h', type: :boolean, desc: 'Display usage information'

    def help(command = nil)
      if command.nil?
        puts <<~HELP
          Human Eval Converter - инструмент для конвертации задач из формата human-eval

          Использование:
            #{$PROGRAM_NAME} COMMAND [OPTIONS]

          Команды:
            convert SOURCE TARGET  # Конвертировать задачи из SOURCE в TARGET каталог
            version              # Показать версию
            help [COMMAND]       # Показать справку по команде

          Опции для convert:
            --create-rules            # Создать каталог rules с файлами промптов
            -k, --keep-existing      # Сохранять существующие файлы
            --preserve-old           # Сохранять старые файлы с временной меткой
            --task NUMBER           # Сгенерировать только задание с номером NUMBER
            --log-level LEVEL       # Уровень логирования (none/normal/debug)

          Общие опции:
            -h, --help              # Показать эту справку
            -v, --version           # Показать версию

          Примеры:
            #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks
            #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks --task 0
            #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks --log-level debug
            #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks -k --preserve-old
        HELP
      else
        super
      end
    end

    map %w[--version -v] => :version

    desc 'version', 'Show version'
    def version
      puts 'Human Eval Converter version 1.0.0'
    end

    desc 'convert SOURCE TARGET', 'Convert human-eval tasks from SOURCE to TARGET directory'
    long_desc <<-LONGDESC
      Конвертирует задачи из формата human-eval в отдельные файлы.

      SOURCE: путь к исходному файлу HumanEval.jsonl
      TARGET: каталог для сохранения сконвертированных задач

      Опции:
        --create-rules            # Создать каталог rules с файлами промптов
        -k, --keep-existing      # Сохранять существующие файлы
        --preserve-old           # Сохранять старые файлы с временной меткой
        --task NUMBER           # Сгенерировать только задание с номером NUMBER
        --log-level LEVEL       # Уровень логирования (none/normal/debug)

      Примеры:
        #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks
        #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks --task 0
        #{$PROGRAM_NAME} convert _src/HumanEval.jsonl tasks --log-level debug
    LONGDESC

    method_option :create_rules,
                  type: :boolean,
                  desc: 'Create rules directory with prompt files'
    method_option :keep_existing,
                  type: :boolean,
                  aliases: '-k',
                  desc: 'Keep existing files'
    method_option :preserve_old,
                  type: :boolean,
                  desc: 'Preserve old files with timestamp'
    method_option :task,
                  type: :string,
                  desc: 'Generate only specific task number'
    method_option :log_level,
                  type: :string,
                  enum: %w[none normal debug],
                  default: 'normal',
                  desc: 'Logging level (none/normal/debug)'

    def convert(source, target)
      if options[:help]
        invoke :help, ['convert']
        return
      end

      options_hash = {
        create_rules: options[:create_rules],
        keep_existing: options[:keep_existing],
        preserve_old: options[:preserve_old],
        task_number: options[:task],
        log_level: options[:log_level]
      }

      converter = HumanEvalConverter.new(source, target, options_hash)
      converter.process
    end

    def self.exit_on_failure?
      true
    end
  end
end
