begin
  require 'terminal-table'
rescue LoadError
  # terminal-table не является необходимой зависимостью
end

begin
  require 'pry'
rescue LoadError
  # pry не является необходимой зависимостью
end

begin
  require 'timeout'
rescue LoadError
  # timeout может быть уже включен в стандартную библиотеку
end

# Модуль Logger предоставляет полную функциональность логирования
# Поддерживает различные уровни логирования (none, error, normal, debug)
# и форматирование сообщений в зависимости от уровня
module Logger
  LOG_LEVELS = {
    none: 0,
    error: 1,
    normal: 2,
    debug: 3
  }.freeze

  # Метод, вызываемый при включении модуля в класс
  # Устанавливает уровень логирования по умолчанию :normal
  # @param base [Class] класс, в который включается модуль
  def self.included(base)
    base.instance_variable_set(:@log_level, LOG_LEVELS[:normal])
  end

  # Устанавливает уровень логирования
  # @param level [Symbol, String] уровень логирования
  def log_level=(level)
    @log_level = if level.is_a?(Symbol)
                   LOG_LEVELS[level] || LOG_LEVELS[:normal]
                 else
                   LOG_LEVELS[level.to_sym] || LOG_LEVELS[:normal]
                 end
  end

  # Проверяет, активен ли указанный уровень логирования
  # @param name [Symbol] проверяемый уровень логирования
  # @return [Boolean] true, если указанный уровень активен
  def log_level?(name)
    name = name.to_sym
    current_level = if respond_to?(:log_level)
                      log_level.to_sym
                    elsif @options && @options[:log_level]
                      @options[:log_level].to_sym
                    else
                      :normal
                    end

    LOG_LEVELS[current_level] >= LOG_LEVELS[name]
  end

  # Основной метод логирования с форматированием сообщений
  # @param message [String] сообщение для логирования
  # @param level [Symbol] уровень логирования (:none, :error, :normal, :debug)
  # @param depth [Integer] глубина стека вызовов для определения источника сообщения
  def log(message, level = :normal, depth = 1)
    return if @log_level && @log_level < LOG_LEVELS[level]

    caller_info = caller_locations(depth, 1).first
    file = caller_info ? File.basename(caller_info.path) : ''
    line = caller_info ? caller_info.lineno : ''

    formatted_message = case level
                        when :debug, :error
                          "#{file}:#{line} [#{level.to_s.upcase}] | #{message}"
                        else
                          message.to_s
                        end

    puts formatted_message
  end

  # Методы базового логирования

  # Метод для логирования отладочных сообщений
  # Форматирует сообщение с указанием файла и строки
  # @param message [String] сообщение для логирования
  def debug(message)
    log(message, :debug, 2)
  end

  # Метод для логирования сообщений об ошибках
  # Форматирует сообщение с указанием файла и строки
  # @param message [String] сообщение для логирования
  def error(message)
    log(message, :error, 2)
  end

  # Метод для логирования обычных сообщений
  # Выводит сообщение без дополнительного форматирования
  # @param message [String] сообщение для логирования
  def warn(message)
    log(message, :normal, 2)
  end

  # Методы с проверкой уровня логирования

  # Метод для логирования отладочных сообщений с проверкой уровня логирования
  # Выводит сообщение только если текущий уровень логирования :debug
  # @param message [String] сообщение для логирования
  def debug_log(message)
    return unless log_level?(:debug)

    debug(message)
  end

  # Метод для логирования обычных сообщений с проверкой уровня логирования
  # Выводит сообщение только если текущий уровень логирования :normal или выше
  # @param message [String] сообщение для логирования
  def normal_log(message)
    return unless log_level?(:normal)

    warn(message)
  end

  # Метод для логирования сообщений об ошибках с проверкой уровня логирования
  # Выводит сообщение только если текущий уровень логирования :error или выше
  # @param message [String] сообщение для логирования
  def error_log(message)
    return unless log_level?(:error)

    error(message)
  end
end
