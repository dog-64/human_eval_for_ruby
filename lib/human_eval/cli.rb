# frozen_string_literal: true

require_relative '../human_eval_converter'

module HumanEval
  class CLI
    attr_accessor :options

    def initialize
      @options = {}
    end

    def version
      puts "Human Eval Converter version 1.0.0"
    end

    def help(command = nil)
      if command == 'convert'
        puts "Конвертирует задачи из формата human-eval"
      else
        puts "Human Eval Converter - инструмент для конвертации задач"
      end
    end

    def convert(source, target)
      raise ArgumentError, 'Source path is required' if source.nil?
      raise ArgumentError, 'Target path is required' if target.nil?

      if options[:help]
        help('convert')
        return
      end

      converter = HumanEvalConverter.new(
        source,
        target,
        {
          create_rules: options[:create_rules],
          keep_existing: options[:keep_existing],
          preserve_old: options[:preserve_old],
          task_number: options[:task],
          log_level: options[:log_level]
        }
      )
      converter.process
    end

    def self.exit_on_failure?
      true
    end
  end
end 