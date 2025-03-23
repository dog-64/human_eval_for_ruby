# frozen_string_literal: true

require 'fileutils'
require 'json'
require_relative '../../test_runner'

module HumanEval
  module Reports
    # Базовый класс для ошибок модуля Reports
    class Error < StandardError; end

    # Класс для генерации отчетов
    class Generator
      AVAILABLE_FORMATS = %w[html markdown all].freeze
      RESULTS_FILE = 'reports/results.json'

      def initialize(options = {})
        @options = options
        @format = options[:format] || 'all'
        @output_dir = options[:output_dir] || 'reports'
        @base_dir = if ENV['RUBY_ENV'] == 'test'
          # В тестовом окружении разрешаем использование временных директорий
          File.expand_path(@output_dir)
        else
          # В продакшене ограничиваем доступ корнем проекта
          File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..'))
        end
        validate_options!
        validate_paths!
      end

      def generate
        results = collect_results
        generate_reports(results)
        results
      end

      private

      def validate_paths!
        if @output_dir.nil? || @output_dir.empty?
          raise Error, "Не указана директория для сохранения отчетов"
        end

        unless ENV['RUBY_ENV'] == 'test'
          expanded_output = File.expand_path(@output_dir)
          unless expanded_output.start_with?(@base_dir)
            raise Error, "Попытка доступа к директории вне рабочей директории: #{@output_dir}"
          end
        end
      end

      def safe_path_join(*parts)
        path = File.join(*parts)
        expanded = File.expand_path(path)
        
        unless ENV['RUBY_ENV'] == 'test'
          unless expanded.start_with?(@base_dir)
            raise Error, "Попытка доступа к файлу вне рабочей директории: #{path}"
          end
        end
        
        expanded
      end

      def collect_results
        results_file = safe_path_join('reports', 'results.json')
        unless File.exist?(results_file)
          raise Error, "Файл с результатами не найден: #{results_file}. Сначала запустите тесты."
        end

        raw_results = JSON.parse(File.read(results_file))
        
        # Преобразуем результаты в нужный формат
        {
          model_stats: calculate_model_stats(raw_results),
          task_results: raw_results || {}
        }
      rescue JSON::ParserError => e
        raise Error, "Ошибка при чтении файла результатов: #{e.message}"
      end

      def calculate_model_stats(results)
        return {} if results.nil? || results.empty?

        models = results.values.first.keys
        total_tasks = results.keys.size

        models.map do |model|
          passed_tasks = results.count { |task, task_results| task_results[model] }
          percentage = (passed_tasks * 100.0 / total_tasks).round
          [model, percentage]
        end.to_h
      end

      def generate_reports(results)
        formatters = select_formatters
        formatters.each do |formatter|
          formatter.new(results, @output_dir).generate
        end
      end

      def select_formatters
        case @format
        when 'html'
          [Formatters::HTML]
        when 'markdown'
          [Formatters::Markdown]
        when 'all'
          [Formatters::HTML, Formatters::Markdown]
        end
      end

      def validate_options!
        unless AVAILABLE_FORMATS.include?(@format)
          raise Error, "Неизвестный формат: #{@format}. Доступные форматы: #{AVAILABLE_FORMATS.join(', ')}"
        end

        raise Error, 'Не указана директория для отчетов' if @output_dir.nil? || @output_dir.empty?
      end
    end
  end
end 