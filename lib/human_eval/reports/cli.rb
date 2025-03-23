# frozen_string_literal: true

require 'thor'
require_relative '../reports'

module HumanEval
  module Reports
    # CLI класс для генерации отчетов
    class CLI
      DEFAULT_OPTIONS = {
        format: 'all',
        output_dir: 'reports'
      }.freeze

      attr_writer :options

      def initialize(options = {})
        @options = DEFAULT_OPTIONS.merge(options)
      end

      def generate
        generator = Generator.new(@options)
        generator.generate
      rescue Error => e
        puts "Ошибка при генерации отчета: #{e.message}"
        exit 1
      end

      private

      def say_error(message)
        say "Error: #{message}", :red
      end

      def display_total(results)
        return unless results && results[:model_stats]

        say "\nРезультаты тестирования моделей:"
        results[:model_stats].sort_by { |_, percentage| -percentage }.each do |model, percentage|
          color = case percentage
                 when 0..33 then :red
                 when 34..66 then :yellow
                 else :green
                 end
          say "- #{model}: #{percentage}%", color
        end
      end
    end
  end
end 