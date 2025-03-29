require 'yaml'
require 'dotenv'

# Класс для управления моделями из конфигурационного файла
# Предоставляет доступ к списку моделей, их информации и категориям
class Models
  # Путь к файлу конфигурации моделей
  MODELS_CONFIG_PATH = File.join(File.dirname(__FILE__), '..', 'config', 'models.yml')

  Dotenv.load

  # Инициализирует объект для работы с моделями
  # @param config_path [String] путь к файлу конфигурации (необязательно)
  def initialize(config_path = nil)
    @config_path = config_path || MODELS_CONFIG_PATH
  end

  # Загружает модели из конфигурационного файла
  # @return [Hash] хеш с моделями
  def all
    @all ||= begin
      loaded_models = {}
      config = YAML.load_file(@config_path)

      # Загружаем модели OpenRouter
      config['openrouter'].each do |key, value|
        loaded_models[key] = value
      end

      # Загружаем модели Ollama
      config['ollama'].each do |key, value|
        loaded_models[key] = value
      end

      loaded_models
    end
  rescue Errno::ENOENT
    raise "Конфигурационный файл не найден: #{@config_path}"
  rescue => e
    raise "Ошибка при загрузке конфигурации моделей: #{e.message}"
  end

  # Возвращает информацию о конкретной модели
  # @param model_key [String] ключ модели
  # @return [Hash, nil] информация о модели или nil, если модель не найдена
  def get(model_key)
    all[model_key]
  end

  # Возвращает список моделей Ollama
  # @return [Array<String>] список ключей моделей Ollama
  def ollama
    all.select { |_, info| info['provider'] == 'ollama' }.keys
  end

  # Возвращает список моделей OpenRouter
  # @return [Array<String>] список ключей моделей OpenRouter
  def openrouter
    all.select { |_, info| info['provider'] == 'openrouter.ai' }.keys
  end

  # Возвращает API ключ для OpenRouter.ai
  # @return [String] API ключ
  def openrouter_api_key
    ENV.fetch('OPENROUTER_API_KEY', nil)
  end

  # Проверяет доступен ли API ключ для OpenRouter.ai
  # @return [Boolean] true, если ключ доступен
  def openrouter_available?
    !openrouter_api_key.nil?
  end
end
