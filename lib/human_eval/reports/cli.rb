# frozen_string_literal: true

require 'thor'
require_relative '../reports'

module HumanEval
  module Reports
    # CLI класс для генерации отчетов
    class CLI
      include Thor::Shell

      DEFAULT_OPTIONS = {
        format: 'all',
        output_dir: 'reports'
      }.freeze

      attr_writer :options

      def initialize(options = {})
        @options = DEFAULT_OPTIONS.merge(options)
        @shell = Thor::Shell::Color.new
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
        @shell.say "Error: #{message}", :red
      end

      def display_total(results)
        return unless results && results[:model_stats]

        @shell.say "\nРезультаты тестирования моделей:"
        results[:model_stats].sort_by { |_, percentage| -percentage }.each do |model, percentage|
          color = case percentage
                 when 0..33 then :red
                 when 34..66 then :yellow
                 else :green
                 end
          @shell.say "- #{model}: #{percentage}%", color
        end
      end
    end
  end
end 