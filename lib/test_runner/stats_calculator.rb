# frozen_string_literal: true

module TestRunner
  # Модуль для расчета статистики тестирования
  module StatsCalculator
    def model_stats
      calculate_model_stats
    end

    private

    def calculate_model_stats
      solutions = find_solution_files
      tasks = extract_tasks(solutions)
      models = extract_models(solutions)

      calculate_stats_for_models(models, tasks)
    end

    def extract_tasks(solutions)
      solutions
        .map { |f| File.basename(f) }
        .map { |f| f.gsub(/-.*$/, '') }
        .uniq
        .sort
    end

    def extract_models(solutions)
      solutions
        .map { |f| extract_model_from_file(f) }
        .compact
        .uniq
        .sort
    end

    def calculate_stats_for_models(models, tasks)
      stats = models.map do |model|
        total_tasks = tasks.size
        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, percentage]
      end

      stats.sort_by! { |_, percentage| -percentage }
    end

    def extract_model_from_file(file)
      filename = File.basename(file)
      return if filename.end_with?('_asserts.rb')

      filename.split('-')[1..].join('-').sub('.rb', '')
    end

    def find_solution_files(task = nil)
      pattern = task ? "tasks/#{task}-*.rb" : 'tasks/t*-*.rb'
      Dir.glob(pattern).reject { |f| f.end_with?('-assert.rb') }
    end
  end
end 