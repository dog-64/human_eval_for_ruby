require 'thor'
require_relative 'human_eval_converter'

module HumanEval
  class CLI < Thor
    desc "convert SOURCE TARGET", "Convert human-eval tasks from SOURCE to TARGET directory"
    method_option :create_rules, type: :boolean, desc: "Create rules directory with prompt files"
    method_option :keep_existing, type: :boolean, aliases: "-k", desc: "Keep existing files"
    method_option :preserve_old, type: :boolean, desc: "Preserve old files with timestamp"
    method_option :task, type: :string, desc: "Generate only specific task number"
    
    def convert(source, target)
      options_hash = {
        create_rules: options[:create_rules],
        keep_existing: options[:keep_existing],
        preserve_old: options[:preserve_old],
        task_number: options[:task]
      }
      
      converter = HumanEvalConverter.new(source, target, options_hash)
      converter.process
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
end 