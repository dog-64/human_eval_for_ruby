#!/usr/bin/env ruby

require "terminal-table"
require "pry"
require "timeout"
require_relative "lib/assert"

class TestRunner
  DONE_MARK = "\e[32m✓\e[0m"  # Зеленый цвет
  FAIL_MARK = "\e[31m✗\e[0m"  # Красный цвет

  def initialize
    @results = {}
  end

  def colorize(text, percentage)
    color = case percentage
            when 0..33 then "\e[31m"    # Красный
            when 34..66 then "\e[33m"   # Желтый
            else "\e[32m"                # Зеленый
            end
    "#{color}#{text}\e[0m"
  end

  def run_all_tests
    if Dir.glob('tasks/t*-*.rb').empty?
      puts "Ошибка: Не найдены файлы с решениями в директории tasks"
      return
    end
    # Находим все файлы с решениями в директории tasks
    solutions = Dir.glob('tasks/t*-*.rb').reject { |f| f.end_with?('-assert.rb') }
    tasks = solutions.map { |f| File.basename(f) }.map { |f| f.gsub(/-.*$/, '') }.uniq.sort

    models = solutions.map do |f|
      filename = File.basename(f)
      next if filename.end_with?('_asserts.rb')
      filename.split('-')[1..-1].join('-').sub('.rb', '')
    end.compact.uniq.sort

    @results = Hash.new { |h, k| h[k] = {} }

    tasks.each do |task|
      task_solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }
      
      task_solutions.each do |solution|
        model = File.basename(solution).split('-')[1..-1].join('-').sub('.rb', '')
        success = test_solution(task, solution)
        @results[task][model] = success
      end
    end

    display_results(tasks, models)
  end

  def run_task_tests(task)
    unless task.to_s.match?(/^t\d+$/)
      puts "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
      return
    end
    test_file = "tasks/#{task}-assert.rb"
    unless File.exist?(test_file)
      puts "Файл с тестами #{test_file} не найден"
      return
    end

    solutions = Dir.glob("tasks/#{task}-*.rb").reject { |f| f.end_with?('-assert.rb') }.sort
    models = solutions.map { |s| File.basename(s).split('-')[1..-1].join('-').sub('.rb', '') }

    @results[task] = {}

    solutions.each do |solution|
      model = File.basename(solution).split('-')[1..-1].join('-').sub('.rb', '')
      success = test_solution(task, solution)
      @results[task][model] = success
    end

    display_results([task], models)
  end

  def run_model_tests(task, model)
    unless task.to_s.match?(/^t\d+$/)
      puts "Ошибка: Неверный формат задачи. Ожидается формат 't<число>' (например, 't1')"
      return
    end

    unless model.to_s.match?(/^[a-zA-Z0-9_-]+$/)
      puts "Ошибка: Неверный формат названия модели"
      return
    end
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
    begin
      test_file = "tasks/#{task}-assert.rb"
      
      unless File.exist?(solution_file)
        puts "\nРешение #{File.basename(solution_file)}:"
        puts "  ❌ Файл решения не найден: #{solution_file}"
        return false
      end
      
      unless File.exist?(test_file)
        puts "\nРешение #{File.basename(solution_file)}:"
        puts "  ❌ Файл тестов не найден: #{test_file}"
        return false
      end

      puts "\nРешение #{File.basename(solution_file)}:"
      
      # Проверяем на пустой файл
      solution_content = File.read(solution_file)
      if solution_content.strip.empty?
        puts "  ❌ Файл решения пуст"
        return false
      end
      
      begin
        # Загружаем решение в контекст
        puts "  📝 Анализ синтаксиса решения..."
        # Создаем временный модуль для проверки синтаксиса
        temp_context = Module.new
        temp_context.module_eval(solution_content)
        puts "  ✅ Синтаксис решения корректен"
      rescue SyntaxError => e
        puts "  ❌ Ошибка синтаксиса в решении:"
        puts "     #{e.message}"
        return false
      end

      # Создаем новый контекст для каждого теста
      test_context = Module.new do
        # Определяем методы в модуле напрямую
        module_eval(solution_content)
        
        # Добавляем методы модуля как методы экземпляра
        extend self
      end
      
      begin
        # Загружаем и выполняем тесты в том же контексте
        test_content = File.read(test_file)
        puts "  🧪 Запуск тестов..."
        test_context.module_eval("start_time = Time.now\n" + test_content, test_file)
        puts "  ✅ Все тесты пройдены успешно"
      rescue Timeout::Error
        puts "  ❌ Превышен лимит времени выполнения (10 секунд)"
        return false
      rescue Object => e
        if e.class.name == 'AssertionError'
          puts "  ❌ Тест не пройден:"
          puts "     #{e.message}"
          if e.message.include?('Ожидалось исключение')
            # Извлекаем информацию об ожидаемом и полученном исключении
            if e.message =~ /Ожидалось исключение (.*?), но было получено (.*?):/
              expected_error = $1
              actual_error = $2
              puts "     Ожидалось исключение: #{expected_error}"
              puts "     Получено исключение:  #{actual_error}"
            end
          elsif e.respond_to?(:expected) && e.respond_to?(:actual)
            puts "     Ожидалось: #{e.expected.inspect}"
            puts "     Получено:  #{e.actual.inspect}"
          end
          
          if e.respond_to?(:line_info) && e.line_info
            file, line = e.line_info.split(':')
            puts "     В файле #{file}:#{line}"
            if File.exist?(file)
              test_line = File.readlines(file)[line.to_i - 2]
              puts "     Тест: #{test_line&.strip}"
            end
          end
        else
          puts "  ❌ Неожиданная ошибка в тесте:"
          puts "     Тип: #{e.class}"
          puts "     Сообщение: #{e.message}"
          puts "     Стек вызовов:"
          e.backtrace.each do |line|
            puts "       #{line}"
          end
        end
        return false
      end
      
      true
    rescue StandardError => e
      puts "  ❌ Неожиданная ошибка:"
      puts "     Тип: #{e.class}"
      puts "     Сообщение: #{e.message}"
      puts "     Стек вызовов:"
      e.backtrace.each do |line|
        puts "       #{line}"
      end
      false
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
      score_row << colorize("#{percentage}%", percentage)
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
  puts "Использование:"
  puts "  ruby run_tests.rb                    # запуск всех тестов"
  puts "  ruby run_tests.rb t8                 # запуск тестов для задачи t8"
  puts "  ruby run_tests.rb t8 deepseek        # запуск тестов задачи t8 для модели deepseek"
end 
