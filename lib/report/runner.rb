require 'fileutils'
require 'json'
require_relative 'generator'

module Report
  # Класс Runner отвечает за загрузку результатов тестирования 
  # и генерацию отчетов с помощью Generator
  class Runner
    DEFAULT_RESULTS_FILE = 'reports/test_results.json'.freeze
    
    def initialize(options = {})
      @options = options
      @reports_dir = options[:output_dir] || 'reports'
      @results_file = options[:results_file] || DEFAULT_RESULTS_FILE
    end
    
    def generate
      ensure_output_directory
      
      # Загружаем результаты тестирования
      unless File.exist?(@results_file)
        puts "Файл с результатами не найден: #{@results_file}"
        puts "Сначала запустите тесты с опцией --report или используйте bin/generate_report"
        return false
      end
      
      begin
        results = load_results(@results_file)
        
        # Генерируем отчет
        generator = Generator.new(results, reports_dir: @reports_dir)
        generator.generate_all
        
        puts "Отчеты успешно созданы в каталоге #{@reports_dir}/"
        true
      rescue JSON::ParserError => e
        puts "Ошибка при чтении файла с результатами: #{e.message}"
        false
      rescue => e
        puts "Ошибка при генерации отчетов: #{e.message}"
        false
      end
    end
    
    private
    
    def ensure_output_directory
      FileUtils.mkdir_p(@reports_dir) unless Dir.exist?(@reports_dir)
    end
    
    def load_results(file_path)
      data = JSON.parse(File.read(file_path))
      {
        model_stats: data['models'],
        task_results: data['tasks']
      }
    end
  end
end 