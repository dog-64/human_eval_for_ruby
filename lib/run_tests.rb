#!/usr/bin/env ruby
# frozen_string_literal: true

require 'terminal-table'
require 'pry'
require_relative 'lib/assert'

class TestRunner
  DONE_MARK = '✓'
  FAIL_MARK = ' '

  def initialize
    @results = {}
  end

  def run_all_tests
    # Находим все файлы с решениями в директории tasks
    solutions = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-asserts.rb') }
    tasks = solutions.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort

    models = solutions.map do |f|
      filename = File.basename(f)
      next if filename.end_with?('_asserts.rb')

      filename.split('-')[1..].join('-').sub('.rb', '')
    end.compact.uniq.sort

    @results = Hash.new { |h, k| h[k] = {} }

    tasks.each do |task|
      task_solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-asserts.rb') }

      task_solutions.each do |solution|
        model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
        success = test_solution(task, solution)
        @results[task][model] = success
      end
    end

    display_results(tasks, models)
  end

  def run_task_tests(task)
    test_file = "tasks/#{task}-asserts.rb"
    unless File.exist?(test_file)
      puts "Файл с тестами #{test_file} не найден"
      return
    end

    solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-asserts.rb') }.sort
    models = solutions.map { |s| File.basename(s).split('-')[1..].join('-').sub('.rb', '') }

    @results[task] = {}

    solutions.each do |solution|
      model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
      success = test_solution(task, solution)
      @results[task][model] = success
    end

    display_results([task], models)
  end

  def run_model_tests(task, model)
    solution = Dir.glob("tasks/#{task}-#{model}.rb").first

    if solution.nil?
      puts "Решение для задачи #{task} модели #{model} не найдено"
      return
    end

    @results[task] = {}
    success = test_solution(task, solution)
    @results[task][model] = success

    display_results([task], [model])
  end

  private

  def test_solution(task, solution_file)
    test_file = "tasks/#{task}-asserts.rb"

    unless File.exist?(solution_file)
      debug "Файл решения не найден: #{solution_file}" if defined?(debug)
      return false
    end

    unless File.exist?(test_file)
      debug "Файл тестов не найден: #{test_file}" if defined?(debug)
      return false
    end

    # Создаем новый контекст для каждого теста
    test_context = Module.new

    # Загружаем решение в контекст
    test_context.module_eval(File.read(solution_file))

    # Загружаем и выполняем тесты в том же контексте
    test_context.module_eval(File.read(test_file))

    true
  rescue StandardError => e
    debug "Ошибка в тесте #{task} (#{solution_file}): #{e.message}" if defined?(debug)
    false
  end

  def display_results(tasks, models)
    rows = []
    model_scores = Hash.new(0)
    total_tasks = tasks.size

    tasks.each do |task|
      row = [task]
      models.each do |model|
        status = @results[task][model]
        row << (status ? DONE_MARK : FAIL_MARK)
        model_scores[model] += 1 if status
      end
      rows << row
    end

    # Добавляем строку с итоговыми оценками
    score_row = ['Score']
    models.each do |model|
      percentage = (model_scores[model] * 100.0 / total_tasks).round
      score_row << "#{percentage}%"
    end
    rows << :separator
    rows << score_row

    table = Terminal::Table.new do |t|
      t.headings = ['Task'] + models
      t.rows = rows
      t.style = {
        alignment: :center,
        padding_left: 1,
        padding_right: 1
      }
    end

    puts table
  end
end

# Использование:
runner = TestRunner.new

if ARGV.empty?
  runner.run_all_tests
elsif ARGV.length == 1
  runner.run_task_tests(ARGV[0])
elsif ARGV.length == 2
  runner.run_model_tests(ARGV[0], ARGV[1])
else
  puts 'Использование:'
  puts '  ruby run_tests.rb                    # запуск всех тестов'
  puts '  ruby run_tests.rb t8                 # запуск тестов для задачи t8'
  puts '  ruby run_tests.rb t8 deepseek        # запуск тестов задачи t8 для модели deepseek'
end
