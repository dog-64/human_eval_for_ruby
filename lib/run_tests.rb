#!/usr/bin/env ruby
# frozen_string_literal: true

require 'terminal-table'
require 'pry'
require_relative 'human_eval/assert'
require_relative 'human_eval/logger'

class TestRunner
  DONE_MARK = '✓'
  FAIL_MARK = ' '

  def initialize
    @results = {}
  end

  def run_all_tests
    # Находим все файлы с решениями в директории tasks
    solutions = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-assert.rb') }
    tasks = solutions.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort

    models = solutions.map do |f|
      filename = File.basename(f)
      next if filename.end_with?('_assert.rb')

      filename.split('-')[1..].join('-').sub('.rb', '')
    end.compact.uniq.sort

    puts "Найдены задачи: #{tasks.inspect}"
    puts "Найдены модели: #{models.inspect}"

    @results = Hash.new { |h, k| h[k] = {} }

    tasks.each do |task|
      task_solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }
      
      # Пропускаем задачи без решений
      next if task_solutions.empty?

      puts "\nОбрабатываем задачу #{task}"
      puts "Найдены решения: #{task_solutions.inspect}"

      task_solutions.each do |solution|
        model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
        puts "Тестируем модель #{model} для задачи #{task}"
        success = test_solution(solution, "tasks/#{task}-assert.rb")
        @results[task][model] = success
        puts "Результат для #{model}: #{success}"
      end
    end

    puts "\nИтоговые результаты:"
    puts @results.inspect

    display_results(tasks, models)
  end

  def run_task_tests(task)
    test_file = "tasks/#{task}-assert.rb"
    unless File.exist?(test_file)
      puts "Файл с тестами #{test_file} не найден"
      return
    end

    solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }.sort
    models = solutions.map { |s| File.basename(s).split('-')[1..].join('-').sub('.rb', '') }

    puts "\nНайдены решения для задачи #{task}:"
    puts solutions.inspect
    puts "Модели: #{models.inspect}"

    @results[task] = {}

    solutions.each do |solution|
      model = File.basename(solution).split('-')[1..].join('-').sub('.rb', '')
      puts "\nТестируем модель #{model} для задачи #{task}"
      success = test_solution(solution, test_file)
      @results[task][model] = success
      puts "Результат для #{model}: #{success}"
    end

    puts "\nИтоговые результаты для задачи #{task}:"
    puts @results[task].inspect

    display_results([task], models)
  end

  def run_model_tests(task, model)
    solution = Dir.glob("tasks/#{task}-#{model}.rb").first

    if solution.nil?
      puts "Решение для задачи #{task} модели #{model} не найдено"
      return
    end

    @results[task] = {}
    success = test_solution(solution, "tasks/#{task}-assert.rb")
    @results[task][model] = success

    display_results([task], [model])
  end

  private

  def test_solution(solution_file, test_file)
    puts "\nТестируем #{solution_file}"
    puts "Тесты из #{test_file}"

    solution_content = File.read(solution_file)
    test_content = File.read(test_file)

    puts "Решение:"
    puts solution_content
    puts "Тесты:"
    puts test_content

    test_context = Module.new do
      extend HumanEval::Assert
      extend HumanEval::Logger
      extend self

      puts "Определяем методы в модуле..."
      instance_eval(solution_content)
      puts "Доступные методы после instance_eval: #{methods(false)}"

      puts "Начинаем выполнение тестов..."
      begin
        instance_eval(test_content)
        puts "Тесты успешно пройдены!"
        return true
      rescue HumanEval::Assert::AssertionError => e
        puts "Ошибка в тесте #{solution_file}: #{e.message}"
        puts "Текущий контекст методов: #{methods(false)}"
        return false
      rescue StandardError => e
        puts "Ошибка в тесте #{solution_file}: #{e}"
        puts "Текущий контекст методов: #{methods(false)}"
        puts e.backtrace.join("\n")
        return false
      end
    end
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
