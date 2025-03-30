require_relative '../logger'

module HumanEval
  # Модуль Logger переехал в корень lib
  # @deprecated Пожалуйста, используйте ::Logger
  module Logger
    LOG_LEVELS = ::Logger::LOG_LEVELS
    
    def self.included(base)
      warn "[DEPRECATION] '#{self}' устарел. Используйте '::Logger' вместо него."
      base.include(::Logger)
    end
  end
end
