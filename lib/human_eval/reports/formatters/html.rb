require 'fileutils'
require 'erb'
require_relative 'base'

module HumanEval
  module Reports
    module Formatters
      # Класс HTML отвечает за генерацию HTML-отчетов на основе результатов тестирования
      class HTML < Base
        def initialize(options = {})
          @output_dir = options[:output_dir]
          @task_results = options[:task_results] || {}
          @model_stats = options[:model_stats] || []
          @timestamp = options[:timestamp] || Time.now.strftime('%Y%m%d_%H%M%S')
        end

        # Генерирует HTML-отчет
        def generate
          create_directory(@output_dir)
          generate_total_report
          generate_full_report
          generate_styles
        end

        private

        # Генерирует общий отчет с суммарной статистикой
        def generate_total_report
          File.open(File.join(@output_dir, 'human_eval_for_ruby_report_total.html'), 'w') do |file|
            file.puts html_header
            file.puts '<h1>Суммарный отчет о тестировании моделей</h1>'
            file.puts "<p>Дата: #{@timestamp}</p>"
            file.puts generate_model_stats_table
            file.puts '</body></html>'
          end
        end

        # Генерирует полный отчет со всеми результатами тестов
        def generate_full_report
          File.open(File.join(@output_dir, 'human_eval_for_ruby_report_full.html'), 'w') do |file|
            file.puts html_header
            file.puts '<h1>Полный отчет о тестировании моделей</h1>'
            file.puts "<p>Дата: #{@timestamp}</p>"
            file.puts generate_model_stats_table
            file.puts generate_task_results_table
            file.puts '</body></html>'
          end
        end

        # Генерирует файл стилей
        def generate_styles
          File.open(File.join(@output_dir, 'style.css'), 'w') do |file|
            file.puts css_styles
          end
        end

        # Возвращает HTML-заголовок
        def html_header
          <<~HTML
            <!DOCTYPE html>
            <html lang="ru">
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>Отчет о тестировании моделей</title>
              <link rel="stylesheet" href="style.css">
            </head>
            <body>
          HTML
        end

        # Возвращает CSS-стили
        def css_styles
          <<~CSS
            body {
              font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
              line-height: 1.6;
              max-width: 1200px;
              margin: 0 auto;
              padding: 20px;
            }
            table {
              border-collapse: collapse;
              width: 100%;
              margin: 20px 0;
            }
            th, td {
              border: 1px solid #ddd;
              padding: 8px;
              text-align: left;
            }
            th {
              background-color: #f5f5f5;
            }
            .success { color: #2ecc71; }
            .failure { color: #e74c3c; }
          CSS
        end

        # Генерирует таблицу со статистикой моделей
        def generate_model_stats_table
          content = "<div class='model-results'><table>"
          content += '<tr><th>Модель</th><th>Успешность</th></tr>'

          @model_stats.each do |model, percentage|
            content += "<tr><td>#{model}</td><td>#{percentage}%</td></tr>"
          end

          content += '</table></div>'
          content
        end

        # Генерирует таблицу с результатами тестов
        def generate_task_results_table
          content = "<div class='task-results'><table>"
          content += '<tr><th>Задача</th>'

          models = @task_results.values.first&.keys || []
          models.each do |model|
            content += "<th>#{model}</th>"
          end
          content += '</tr>'

          @task_results.each do |task, results|
            content += "<tr><td>#{task}</td>"
            models.each do |model|
              success = results[model]
              status = success ? '✅' : '❌'
              css_class = success ? 'success' : 'failure'
              content += "<td class='#{css_class}'>#{status}</td>"
            end
            content += '</tr>'
          end

          content += '</table></div>'
          content
        end

        # Рендерит HTML-отчет с использованием ERB шаблона (заглушка для совместимости)
        def render_html
          html_content = "<!DOCTYPE html>\n<html><body>"
          html_content += "<h1>Отчет о тестировании моделей</h1>"
          html_content += "<p>Дата: #{@timestamp}</p>"
          html_content += generate_model_stats_table
          html_content += generate_task_results_table
          html_content += "</body></html>"
          html_content
        end

        # Возвращает цвет для процента успешных тестов
        def percentage_color(percentage)
          case percentage
          when 90..100 then 'success'
          when 70...90 then 'warning'
          else 'danger'
          end
        end

        # Форматирует процент для отображения
        def format_percentage(percentage)
          "#{percentage}%"
        end

        # Возвращает знак для результата теста
        def result_mark(result)
          result ? '✓' : '✗'
        end

        # Возвращает CSS-класс для результата теста
        def result_class(result)
          result ? 'success' : 'danger'
        end
      end
    end
  end
end
