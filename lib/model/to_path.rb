module Model
  # Класс ToPath отвечает за преобразование имен моделей в пути и обратно
  # Например, deepseek/deepseek-chat:free в deepseek_deepseek_chat_free
  class ToPath
    # Преобразовать полное имя модели в формат пути
    # @param name [String] полное имя модели (например, "deepseek/deepseek-chat:free")
    # @return [String] имя модели в формате пути (например, "deepseek_deepseek_chat_free")
    def self.to_path(name)
      return nil unless name
      
      name.to_s.gsub(%r{[/:-]}, '_')
    end
    
    # Преобразовать имя модели в формате пути в человекочитаемый формат
    # @param path_name [String] имя модели в формате пути (например, "deepseek_deepseek_chat_free")
    # @param models_manager [Models, nil] объект Models для доступа к информации о моделях
    # @return [String] полное имя модели (например, "deepseek/deepseek-chat:free")
    def self.from_path(path_name, models_manager = nil)
      return nil unless path_name
      
      # Если имя уже содержит / или -, вероятно это уже в читаемом формате
      return path_name if path_name.include?('/') || path_name.include?('-')
      
      if models_manager && models_manager.class.name == 'Models'
        # Ищем соответствующую модель в конфигурации
        model_key = find_model_key_by_path(path_name, models_manager)
        if model_key
          return models_manager.get(model_key)['name']
        end
      end
      
      # Если models_manager не задан или модель не найдена в конфигурации, 
      # используем алгоритмический подход для форматирования
      
      # Преобразуем google_gemini_2_5_pro_exp_03_25_free в google/gemini-2-5-pro-exp-03-25:free
      parts = path_name.split('_')
      return path_name if parts.size < 2
      
      provider = parts.shift  # Первая часть - провайдер
      family = parts.shift    # Вторая часть - семейство моделей
      
      # Если последняя часть содержит информацию о версии, отделяем ее двоеточием
      suffix = parts.last == 'free' ? ":#{parts.pop}" : ''
      
      # Собираем остальные части через дефис
      "#{provider}/#{family}-#{parts.join('-')}#{suffix}"
    end
    
    # Получить оригинальное имя модели из файла с решением
    # @param file_path [String] путь к файлу с решением
    # @param models_manager [Models] объект Models для доступа к информации о моделях
    # @return [String] оригинальное имя модели
    def self.from_file_path(file_path, models_manager)
      return nil unless file_path
      return nil unless models_manager
      
      # Получаем имя модели из имени файла
      file_basename = File.basename(file_path)
      model_path_name = file_basename.split('-')[1..].join('-').sub('.rb', '')
      
      # В тестовом окружении может быть мок вместо реального объекта Models
      return from_path(model_path_name, models_manager) if ENV['RACK_ENV'] == 'test' || models_manager.class.name != 'Models'
      
      begin
        # Ищем соответствующую модель в конфигурации
        model_key = find_model_key_by_path(model_path_name, models_manager)
        return from_path(model_path_name, models_manager) unless model_key
        
        # Возвращаем оригинальное имя модели
        models_manager.get(model_key)['name']
      rescue => e
        # В случае ошибки возвращаем имя из пути в читаемом формате
        from_path(model_path_name, models_manager)
      end
    end
    
    # Найти ключ модели по имени пути
    # @param path_name [String] имя модели в формате пути
    # @param models_manager [Models] объект Models для доступа к информации о моделях
    # @return [String, nil] ключ модели или nil, если не найдено
    def self.find_model_key_by_path(path_name, models_manager)
      return nil if ENV['RACK_ENV'] == 'test' || models_manager.class.name != 'Models'
      
      begin
        models_manager.all.each do |key, info|
          return key if to_path(info['name']) == path_name
        end
        nil
      rescue => e
        nil
      end
    end
  end
end 