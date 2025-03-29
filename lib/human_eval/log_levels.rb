module HumanEval
  # Модуль LogLevels предоставляет методы для логирования сообщений различного уровня важности
  # Позволяет управлять выводом сообщений в зависимости от установленного уровня логирования
  # Поддерживает уровни: debug, normal, error
  module LogLevels
    def debug_log(message)
      return unless log_level?(:debug)

      debug(message)
    end

    def normal_log(message)
      return unless log_level?(:normal)

      warn(message)
    end

    def error_log(message)
      return unless log_level?(:error)

      error(message)
    end

    def log_level?(name)
      name = name.to_sym
      @options[:log_level].to_sym == name || (respond_to?(:log_level) && log_level.to_sym == name)
    end
  end
end
