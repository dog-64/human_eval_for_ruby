module Runner
  # Модуль для форматирования и отображения результатов тестирования
  module Report
    def display_total_console(tasks, models)
      return if models.empty? || tasks.empty? || @results.empty?
      
      # Подсчитываем статистику для каждой модели
      model_stats = models.map do |model|
        # Находим все задачи, для которых у нас есть результаты данной модели
        total_tasks = tasks.count { |task| @results[task]&.key?(model) }
        next nil if total_tasks.zero? # Пропускаем модели без результатов
        
        # Подсчитываем количество успешно пройденных тестов
        passed_tasks = tasks.count { |task| @results[task][model] == true }
        percentage = total_tasks > 0 ? (passed_tasks * 100.0 / total_tasks).round : 0
        [model, passed_tasks, total_tasks, percentage]
      end.compact

      # Сортируем по убыванию процента успешных тестов
      model_stats.sort_by! { |_, _, _, percentage| -percentage }

      # Выводим общую информацию
      log "\n📊 Общая статистика:"
      log "- Всего задач: #{tasks.size}"
      log "- Всего моделей: #{models.size}"
      log "- Моделей с результатами: #{model_stats.size}"
      
      # Рассчитываем общую успешность всех моделей
      if model_stats.any?
        total_passed = model_stats.sum { |_, passed, _, _| passed }
        total_total = model_stats.sum { |_, _, total, _| total }
        overall_percentage = (total_passed * 100.0 / total_total).round
        log "- Общая успешность: #{colorize("#{total_passed}/#{total_total} (#{overall_percentage}%)", overall_percentage)}"
      end

      # Выводим статистику по моделям
      log "\n🤖 Результаты тестирования моделей:"
      if model_stats.empty?
        log "- Нет данных для отображения"
      else
        model_stats.each do |model, passed, total, percentage|
          log "- #{model}: #{colorize("#{passed}/#{total} (#{percentage}%)", percentage)}"
        end
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