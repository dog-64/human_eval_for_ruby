# frozen_string_literal: true

module HumanEval
  module Reports
    module Formatters
      # Базовый класс для форматтеров отчетов
      class Base
        attr_reader :output_dir, :task_results, :model_stats, :timestamp

        def initialize(options = {})
          validate_required_options!(options)
          validate_output_dir_safety!(options[:output_dir])
          @output_dir = options[:output_dir]
          @task_results = options[:task_results]
          @model_stats = options[:model_stats]
          @timestamp = options[:timestamp] || Time.now.strftime('%Y-%m-%d %H:%M:%S')
        end

        def generate
          raise NotImplementedError, 'Метод generate должен быть реализован в подклассе'
        end

        private

        def validate_required_options!(options)
          required_options = [:output_dir, :task_results, :model_stats]
          missing_options = required_options.select { |opt| options[opt].nil? }
          return if missing_options.empty?

          raise ArgumentError, "Отсутствуют обязательные параметры: #{missing_options.join(', ')}"
        end

        def validate_output_dir_safety!(path)
          absolute_path = File.expand_path(path)
          spec_dir = File.expand_path('spec')
          
          unless absolute_path.start_with?(spec_dir)
            raise ArgumentError, "Путь #{path} должен находиться внутри каталога spec"
          end
        end
      end
    end
  end
end 