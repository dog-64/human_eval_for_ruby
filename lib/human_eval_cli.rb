require 'thor'
require_relative 'human_eval_converter'

class HumanEvalCLI < Thor
  desc "convert INPUT_FILE OUTPUT_DIR", "Конвертирует файл human-eval в отдельные задачи"
  option :create_rules, 
         type: :boolean, 
         default: false, 
         desc: "Создать каталог rules с файлами промптов"
  option :keep_existing,
         type: :boolean,
         default: false,
         aliases: "-k",
         desc: "Сохранять существующие файлы (не перезаписывать)"
  
  def convert(input_file = nil, output_dir = nil)
    if input_file.nil? || output_dir.nil?
      usage
      exit 1
    end

    unless File.exist?(input_file)
      puts "Ошибка: Файл #{input_file} не найден"
      usage
      exit 1
    end

    converter = HumanEvalConverter.new(
      input_file, 
      output_dir, 
      create_rules: options[:create_rules],
      keep_existing: options[:keep_existing]
    )
    converter.process
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
    usage
    exit 1
  end

  private

  def usage
    puts "\nИспользование:"
    puts "  human_eval_converter convert INPUT_FILE OUTPUT_DIR [опции]"
    puts "\nОпции:"
    puts "  --create-rules    Создать каталог rules с файлами промптов"
    puts "  -k, --keep-existing  Сохранять существующие файлы (не перезаписывать)"
    puts "\nПримеры:"
    puts "  human_eval_converter convert input.json output_dir"
    puts "  human_eval_converter convert input.json output_dir --create-rules"
    puts "  human_eval_converter convert input.json output_dir --keep-existing"
  end

  def self.exit_on_failure?
    true
  end
end 