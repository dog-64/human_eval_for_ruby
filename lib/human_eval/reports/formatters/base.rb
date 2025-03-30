require 'fileutils'

module HumanEval
  module Reports
    module Formatters
      # Базовый класс для всех форматтеров отчетов
      # Предоставляет общую функциональность и определяет интерфейс
      # для конкретных реализаций форматтеров
      class Base
        attr_reader :output_dir, :task_results, :model_stats, :timestamp

        # Инициализирует форматтер
        # @param options [Hash] опции для форматтера
        # @option options [String] :output_dir директория для сохранения отчетов (обязательный)
        # @option options [Hash] :task_results результаты тестирования (обязательный)
        # @option options [Array] :model_stats статистика моделей (обязательный)
        # @option options [String] :timestamp временная метка создания отчета
        def initialize(options = {})
          validate_required_options(options)
          validate_output_dir(options[:output_dir])

          @output_dir = options[:output_dir]
          @task_results = options[:task_results]
          @model_stats = options[:model_stats]
          @timestamp = options[:timestamp] || Time.now.strftime('%Y-%m-%d %H:%M:%S')
        end

        # Генерирует отчет
        # Метод должен быть переопределен в конкретных реализациях форматтеров
        def generate
          raise NotImplementedError, 'Метод generate должен быть переопределен в подклассах'
        end

        private

        # Валидирует обязательные опции
        # @param options [Hash] опции для валидации
        # @raise [ArgumentError] если отсутствуют обязательные опции
        def validate_required_options(options)
          %i[output_dir task_results model_stats].each do |required_option|
            unless options[required_option]
              raise ArgumentError, "Опция #{required_option} обязательна"
            end
          end
        end

        # Валидирует директорию для сохранения отчетов
        # @param output_dir [String] путь к директории
        # @raise [ArgumentError] если путь находится вне проекта
        def validate_output_dir(output_dir)
          absolute_path = File.expand_path(output_dir)
          spec_dir = File.join(Dir.pwd, 'spec')
          
          unless absolute_path.start_with?(spec_dir) || ENV['RACK_ENV'] == 'production'
            raise ArgumentError, "Каталог #{output_dir} должен находиться внутри каталога spec" 
          end
        end

        # Создает директорию для сохранения отчетов
        # @param path [String] путь к директории
        def create_directory(path)
          FileUtils.mkdir_p(path)
        end
      end
    end
  end
end
