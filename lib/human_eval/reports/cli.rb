# frozen_string_literal: true

require 'thor'
require_relative '../reports'

module HumanEval
  module Reports
    # CLI класс для генерации отчетов
    class CLI < Thor
      default_command :generate

      desc 'generate', 'Генерирует HTML отчет о тестировании моделей'
      method_option :format, type: :string, default: 'html',
                           desc: 'Формат отчета (только html)'
      method_option :output_dir, type: :string, default: 'reports',
                               desc: 'Директория для сохранения отчетов'
      method_option :results_file, type: :string, default: 'reports/results.json',
                                desc: 'Файл с результатами тестирования'
      def generate
        validate_results_file!(options[:results_file])

        HumanEval::Reports.generate_reports(
          results_file: options[:results_file],
          output_dir: options[:output_dir],
          format: options[:format]
        )

        say "Отчеты сгенерированы в директории: #{options[:output_dir]}"
        say "Формат: #{options[:format]}"
      rescue ArgumentError => e
        say_error e.message
        exit 1
      rescue JSON::ParserError => e
        say_error "Ошибка при чтении файла результатов: #{e.message}"
        exit 1
      rescue StandardError => e
        say_error "Неожиданная ошибка: #{e.message}"
        exit 1
      end

      private

      def say_error(message)
        say "Error: #{message}", :red
      end

      def validate_results_file!(file_path)
        unless File.exist?(file_path)
          raise ArgumentError, "Файл с результатами #{file_path} не существует"
        end
      end
    end
  end
end 
