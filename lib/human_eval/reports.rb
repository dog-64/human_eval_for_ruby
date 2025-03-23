# frozen_string_literal: true

require 'json'
require_relative 'reports/formatters/html'
require_relative 'reports/cli'
require 'fileutils'

module HumanEval
  module Reports
    AVAILABLE_FORMATS = %w[html].freeze

    class << self
      def generate_reports(results_file:, output_dir:, format: 'html')
        validate_format!(format)
        validate_path_safety!(results_file)
        validate_path_safety!(output_dir)
        validate_results_file!(results_file)

        results = load_results(results_file)
        model_stats = calculate_model_stats(results)
        timestamp = Time.now.strftime('%Y-%m-%d %H:%M:%S')

        generate_by_format(format, output_dir, results, model_stats, timestamp)
      end

      private

      def validate_format!(format)
        return if AVAILABLE_FORMATS.include?(format)

        raise ArgumentError, "Неподдерживаемый формат: #{format}. Доступные форматы: #{AVAILABLE_FORMATS.join(', ')}"
      end

      def validate_path_safety!(path)
        absolute_path = File.expand_path(path)
        spec_dir = File.expand_path('spec')
        
        unless absolute_path.start_with?(spec_dir)
          raise ArgumentError, "Путь #{path} должен находиться внутри каталога spec"
        end
      end

      def validate_results_file!(file_path)
        unless File.exist?(file_path)
          raise ArgumentError, "Файл с результатами #{file_path} не существует"
        end
      end

      def load_results(file_path)
        JSON.parse(File.read(file_path))['results']
      end

      def calculate_model_stats(results)
        stats = Hash.new { |h, k| h[k] = { total: 0, success: 0 } }
        
        results.each do |_task, model_results|
          model_results.each do |model, success|
            stats[model][:total] += 1
            stats[model][:success] += 1 if success
          end
        end

        stats.map do |model, data|
          success_rate = (data[:success] * 100.0 / data[:total]).round
          [model, success_rate]
        end.sort_by { |_, rate| -rate }
      end

      def generate_by_format(format, output_dir, results, model_stats, timestamp)
        case format
        when 'html'
          Formatters::HTML.new(
            output_dir: output_dir,
            task_results: results,
            model_stats: model_stats,
            timestamp: timestamp
          ).generate
        end
      end
    end
  end
end 