# frozen_string_literal: true

module HumanEval
  module Reports
    module Formatters
      # Форматтер для Markdown отчетов
      class Markdown < Base
        def generate
          generate_total_report
          update_readme
        end

        private

        def generate_total_report
          content = "## Рейтинг\n\n"
          model_stats.each do |model, percentage|
            content += "- #{model}: #{percentage}%\n"
          end
          
          File.write(File.join(output_dir, 'total.md'), content)
        end

        def update_readme
          readme_path = File.join(output_dir, 'README.md')
          return unless File.exist?(readme_path)

          content = File.read(readme_path)
          new_content = content.sub(
            /## Рейтинг.*?(?=##|\z)/m,
            File.read(File.join(output_dir, 'total.md')) + "\n"
          )
          
          File.write(readme_path, new_content)
        end
      end
    end
  end
end 