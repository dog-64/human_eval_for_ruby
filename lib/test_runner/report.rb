module TestRunner
  # Модуль для форматирования и отображения результатов тестирования
  module Report
    def display_total_console(tasks, models)
      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        total_tasks = tasks.size
        passed_tasks = tasks.count { |task| @results[task][model] }
        percentage = (passed_tasks * 100.0 / total_tasks).round
        [model, percentage]
      end

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, percentage| -percentage }

      # Выводим общую статистику
      log "\nРезультаты тестирования моделей:"
      model_stats.each do |model, percentage|
        log "- #{model}: #{colorize("#{percentage}%", percentage)}"
      end
    end

    def colorize(text, percentage)
      color = case percentage
              when 0..33 then "\e[31m" # Красный
              when 34..66 then "\e[33m" # Желтый
              else "\e[32m" # Зеленый
              end
      "#{color}#{text}\e[0m"
    end

    def get_model_info(model_key)
      # Используем класс Models для получения информации о модели
      begin
        require_relative '../models'
        models_manager = Models.new
        model_info = models_manager.get(model_key)
        model_info || { 'name' => model_key, 'provider' => 'unknown' }
      rescue => e
        # В случае ошибки возвращаем базовую информацию
        { 'name' => model_key, 'provider' => 'unknown' }
      end
    end

    def get_display_model_name(model_key)
      model_info = get_model_info(model_key)
      name = model_info['name']
      provider = model_info['provider']
      note = model_info['note']

      display_name = name.dup
      display_name << " (#{provider})" if provider != 'unknown'
      display_name << " - #{note}" if note

      display_name
    end

    # Форматирует название модели с мягкими переносами
    # @param text [String] текст для форматирования
    # @return [String] отформатированный текст с мягкими переносами
    def add_soft_hyphens(text)
      text.gsub('_', '_&shy;')
    end
  end
end 