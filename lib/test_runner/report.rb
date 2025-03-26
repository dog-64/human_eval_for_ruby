# frozen_string_literal: true

require 'json'
require 'fileutils'

module TestRunner
  class Report
    def initialize(options = {})
      @options = options
      @report_file = 'reports/total.jsonl'
      @detailed_report_file = 'reports/detailed.jsonl'
      ensure_report_directory
    end

    def save_result(model:, task:, success:)
      result = {
        model: model,
        task: task,
        success: success,
        timestamp: Time.now.utc.iso8601
      }
      
      # Всегда сохраняем детальный отчет
      File.open(@detailed_report_file, 'a') do |f|
        f.puts result.to_json
      end

      # Если report_total = true, сохраняем только общую статистику
      if @options[:report_total]
        save_total_stats(model, success)
      end
    end

    def save_total_stats(model, success)
      stats = load_total_stats
      stats[model] ||= { total: 0, passed: 0 }
      stats[model][:total] += 1
      stats[model][:passed] += 1 if success

      File.open(@report_file, 'w') do |f|
        stats.each do |model_name, model_stats|
          percentage = (model_stats[:passed] * 100.0 / model_stats[:total]).round
          summary = {
            model: model_name,
            total_tasks: model_stats[:total],
            passed_tasks: model_stats[:passed],
            success_rate: percentage,
            timestamp: Time.now.utc.iso8601
          }
          f.puts summary.to_json
        end
      end
    end

    private

    def ensure_report_directory
      FileUtils.mkdir_p(File.dirname(@report_file))
    end

    def load_total_stats
      return {} unless File.exist?(@report_file)

      stats = {}
      File.readlines(@report_file).each do |line|
        data = JSON.parse(line, symbolize_names: true)
        stats[data[:model]] = {
          total: data[:total_tasks],
          passed: data[:passed_tasks]
        }
      end
      stats
    rescue JSON::ParserError, TypeError
      {} # Возвращаем пустой хэш в случае ошибки парсинга
    end
  end
end 