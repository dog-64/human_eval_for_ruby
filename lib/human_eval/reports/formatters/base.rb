# frozen_string_literal: true

module HumanEval
  module Reports
    module Formatters
      # Базовый класс для форматтеров отчетов
      class Base
        attr_reader :results, :output_dir

        def initialize(results, output_dir)
          @results = results
          @output_dir = output_dir
          FileUtils.mkdir_p(output_dir)
        end

        def generate
          raise NotImplementedError, 'Subclasses must implement #generate'
        end

        protected

        def model_stats
          @results[:model_stats]
        end

        def task_results
          @results[:task_results]
        end

        def timestamp
          Time.now.strftime('%Y-%m-%d %H:%M:%S')
        end
      end
    end
  end
end 