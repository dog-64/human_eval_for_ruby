# frozen_string_literal: true

require 'fileutils'
require 'json'
require_relative '../../runner/runner'

module HumanEval
  module Reports
    # Базовый класс для ошибок модуля Reports
    class Error < StandardError; end

    # Класс для генерации отчетов
    class Generator
      AVAILABLE_FORMATS = %w[html markdown all].freeze
      RESULTS_FILE = 'reports/results.json'

      def initialize(options = {})
        @options = options
        @output_dir = options[:output_dir]
        @format = options[:format] || 'all'
        @results = options[:results] || {}
        @tasks = options[:tasks] || []
        @models = options[:models] || []

        validate_options!
        validate_paths!
      end

      def generate
        results = @results.empty? ? collect_results : @results
        generate_reports(results)
        { model_stats: calculate_model_stats(results) }
      end

      private

      def validate_paths!
        raise Error, 'Не указана директория для сохранения отчетов' if @output_dir.nil? || @output_dir.empty?

        return if ENV['RUBY_ENV'] == 'test'

        base_dir = File.expand_path('.')
        output_path = File.expand_path(@output_dir)

        unless output_path.start_with?(base_dir)
          raise Error, 'Директория для отчетов должна находиться внутри текущего проекта'
        end
      end

      def validate_options!
        return if AVAILABLE_FORMATS.include?(@format)

        raise Error, "Неверный формат отчета: #{@format}. Доступные форматы: #{AVAILABLE_FORMATS.join(', ')}"
      end

      def collect_results
        return {} unless File.exist?(RESULTS_FILE)

        begin
          JSON.parse(File.read(RESULTS_FILE))
        rescue JSON::ParserError => e
          raise Error, "Ошибка при чтении файла результатов: #{e.message}"
        end
      end

      def generate_reports(results)
        case @format
        when 'html'
          generate_html_report(results)
        when 'markdown'
          generate_markdown_report(results)
        when 'all'
          generate_html_report(results)
          generate_markdown_report(results)
        end
      end

      def generate_html_report(results)
        FileUtils.mkdir_p(@output_dir)
        full_report_file = File.join(@output_dir, 'report.html')
        File.write(File.join(@output_dir, 'style.css'), generate_css)

        File.open(full_report_file, 'w') do |file|
          file.puts generate_html_header

          # Добавляем заголовок и описание
          file.puts '<div class="container">'
          file.puts '<h1>Отчет о тестировании моделей</h1>'
          file.puts '<p>Результаты тестирования различных моделей на наборе задач.</p>'

          # Добавляем общую статистику
          file.puts '<h2>Общая статистика по моделям</h2>'
          file.puts '<table class="stats-table">'
          file.puts '<tr><th>Модель</th><th>Успешность</th></tr>'

          model_stats = calculate_model_stats(results)
          model_stats.sort_by { |_, percentage| -percentage }.each do |model, percentage|
            color_class = if percentage == 100
                           'success'
                         elsif percentage.zero?
                           'failure'
                         else
                           ''
                         end
            file.puts "<tr><td>#{model}</td><td class='#{color_class}'>#{percentage}%</td></tr>"
          end

          file.puts '</table>'

          # Добавляем детальную таблицу результатов
          file.puts '<h2>Детальные результаты</h2>'
          file.puts '<div class="table-container">'
          file.puts '<table class="results-table">'

          # Заголовок таблицы
          file.puts '<tr><th>Задача</th>'
          @models.each do |model|
            file.puts "<th>#{model}</th>"
          end
          file.puts '</tr>'

          # Данные таблицы
          @tasks.each do |task|
            file.puts '<tr>'
            file.puts "<td>#{task}</td>"

            @models.each do |model|
              status = results[task][model]
              css_class = status ? 'success' : 'failure'
              symbol = status ? '✓' : '✗'
              file.puts "<td class='#{css_class}'>#{symbol}</td>"
            end

            file.puts '</tr>'
          end

          file.puts '</table>'
          file.puts '</div>'
          file.puts '</div>'
          file.puts '</body></html>'
        end
      end

      def generate_markdown_report(results)
        output_file = File.join(@output_dir, 'report.md')

        File.open(output_file, 'w') do |file|
          file.puts "# Отчет о тестировании моделей\n\n"

          # Общая статистика
          file.puts "## Общая статистика\n\n"
          model_stats = calculate_model_stats(results)
          model_stats.sort_by { |_, percentage| -percentage }.each do |model, percentage|
            file.puts "- #{model}: #{percentage}%"
          end

          # Детальные результаты
          file.puts "\n## Детальные результаты\n\n"
          file.puts "| Задача | #{@models.join(' | ')} |"
          file.puts "|#{'-' * 8}|#{@models.map { |_| '-' * 8 }.join('|')}|"

          @tasks.each do |task|
            row = [task]
            @models.each do |model|
              status = results[task][model]
              mark = status ? '✓' : '✗'
              row << mark
            end
            file.puts "| #{row.join(' | ')} |"
          end
        end
      end

      def calculate_model_stats(results)
        return {} if results.empty?

        tasks = @tasks.empty? ? results.keys : @tasks
        models = @models.empty? ? results.values.flat_map(&:keys).uniq : @models

        models.map do |model|
          total_tasks = tasks.size
          passed_tasks = tasks.count { |task| results[task][model] }
          percentage = (passed_tasks * 100.0 / total_tasks).round
          [model, percentage]
        end.to_h
      end

      def generate_html_header
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

      def generate_css
        <<~CSS
          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
          }

          .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          h1, h2 {
            color: #2c3e50;
            margin-top: 0;
          }

          h1 {
            font-size: 2em;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
          }

          h2 {
            font-size: 1.5em;
            margin: 30px 0 15px;
          }

          p {
            margin: 0 0 15px;
          }

          table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
            background-color: white;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
          }

          th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
          }

          th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
          }

          tr:hover {
            background-color: #f8f9fa;
          }

          .stats-table {
            max-width: 600px;
          }

          .results-table {
            margin-top: 20px;
          }

          .table-container {
            overflow-x: auto;
            margin-top: 20px;
          }

          .success {
            color: #28a745;
            font-weight: bold;
          }

          .failure {
            color: #dc3545;
            font-weight: bold;
          }

          @media (max-width: 768px) {
            body {
              padding: 10px;
            }

            .container {
              padding: 15px;
            }

            th, td {
              padding: 8px;
            }
          }
        CSS
      end
    end
  end
end 