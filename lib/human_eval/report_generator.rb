require 'json'
require 'fileutils'

module HumanEval
  class ReportGenerator
    def initialize(results, reports_dir: 'reports')
      @results = results
      @reports_dir = reports_dir
      FileUtils.mkdir_p(@reports_dir)
    end

    def generate_all
      save_json
      create_html_reports
      create_markdown
      update_readme
    end

    private

    def save_json
      begin
        FileUtils.mkdir_p(@reports_dir)
        json_data = {
          timestamp: Time.now.to_s,
          models: @results[:model_stats].to_h,
          tasks: @results[:task_results]
        }
        
        json_file = File.join(@reports_dir, 'results.json')
        File.write(json_file, JSON.pretty_generate(json_data))
      rescue => e
        puts "Error saving JSON: #{e.class} - #{e.message}"
        puts e.backtrace
      end
    end

    def create_html_reports
      html_header = generate_html_header
      create_total_html(html_header)
      create_full_html(html_header)
    end

    def create_markdown
      content = "## Рейтинг\n\n"
      @results[:model_stats].each do |model, percentage|
        content += "- #{model}: #{percentage}%\n"
      end
      File.write(File.join(@reports_dir, 'total.md'), content)
    end

    def update_readme
      readme_path = File.join(@reports_dir, 'README.md')
      return unless File.exist?(readme_path)

      readme = File.read(readme_path)
      new_content = readme.sub(
        /## Рейтинг.*?(?=##|\z)/m,
        File.read(File.join(@reports_dir, 'total.md')) + "\n"
      )
      File.write(readme_path, new_content)
    end

    def add_soft_hyphens(text)
      text.gsub('_', '_&shy;')
    end

    def find_solution_files(task = nil)
      pattern = task ? "#{task}_solution.rb" : "*_solution.rb"
      Dir.glob(File.join(@reports_dir, 'solutions', "**", pattern)).sort
    end

    def generate_html_header
      <<~HTML
        <!DOCTYPE html>
        <html lang="ru">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Отчет о тестировании моделей</title>
          <style>
            body {
              font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
                           Helvetica, Arial, sans-serif;
              line-height: 1.6;
              max-width: 1200px;
              margin: 0 auto;
              padding: 20px;
              color: #333;
              hyphens: auto;
              word-wrap: break-word;
              overflow-wrap: break-word;
            }
            h1, h2, h3 { color: #2c3e50; }
            table {
              border-collapse: collapse;
              width: 100%;
              margin-bottom: 20px;
              font-size: 14px;
            }
            th, td {
              hyphens: auto;
              word-wrap: break-word;
              overflow-wrap: break-word;
              border: 1px solid #ddd;
              padding: 8px;
              text-align: center;
            }
            th {
              background-color: #f2f2f2;
              position: sticky;
              top: 0;
              vertical-align: top;
            }
            tr:nth-child(even) { background-color: #f9f9f9; }
            .success {
              color: #27ae60;
              font-weight: bold;
            }
            .failure {
              color: #e74c3c;
              font-weight: bold;
            }
            .model-results td:first-child,
            .task-results td:first-child {
              text-align: left;
              font-weight: bold;
            }
            .task-results th { vertical-align: top; }
            @media (max-width: 768px) {
              table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
              }
            }
          </style>
        </head>
        <body>
      HTML
    end

    def create_total_html(html_header)
      File.open(File.join(@reports_dir, 'human_eval_for_ruby_report_total.html'), 'w') do |file|
        file.puts html_header
        file.puts '<h1>Суммарный отчет о тестировании моделей</h1>'
        file.puts "<p>Дата: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}</p>"
        file.puts "<div class='model-results'>"
        file.puts '<table>'
        file.puts '<tr><th>Модель</th><th>Успешность</th></tr>'
        @results[:model_stats].each do |model, percentage|
          file.puts "<tr><td>#{model}</td><td>#{percentage}%</td></tr>"
        end
        file.puts '</table></div></body></html>'
      end
    end

    def create_full_html(html_header)
      File.open(File.join(@reports_dir, 'human_eval_for_ruby_report_full.html'), 'w') do |file|
        file.puts html_header
        file.puts '<h1>Отчет о тестировании моделей</h1>'
        file.puts "<p>Дата: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}</p>"
        
        # Результаты по моделям
        file.puts '<h2>Результаты по моделям</h2>'
        file.puts "<div class='model-results'>"
        file.puts '<table>'
        file.puts '<tr><th>Модель</th><th>Успешность</th></tr>'
        @results[:model_stats].each do |model, percentage|
          file.puts "<tr><td>#{model}</td><td>#{percentage}%</td></tr>"
        end
        file.puts '</table></div>'

        # Детальные результаты
        file.puts '<h2>Детальные результаты по задачам</h2>'
        file.puts "<div class='task-results'>"
        file.puts '<table>'
        
        # Заголовок таблицы с задачами
        models = @results[:task_results].values.first&.keys || []
        file.puts '<tr><th>Задача</th>'
        models.each do |model|
          file.puts "<th>#{model}</th>"
        end
        file.puts '</tr>'

        # Данные по задачам
        @results[:task_results].each do |task, results|
          file.puts "<tr><td>#{task}</td>"
          results.each do |_, success|
            status = success ? '✓' : '✗'
            css_class = success ? 'success' : 'failure'
            file.puts "<td class='#{css_class}'>#{status}</td>"
          end
          file.puts '</tr>'
        end
        
        file.puts '</table></div></body></html>'
      end
    end
  end
end 