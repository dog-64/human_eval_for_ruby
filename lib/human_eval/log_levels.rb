# frozen_string_literal: true

module HumanEval
  module LogLevels
    def debug_log(message)
      # Просто выводим сообщение в stdout
      puts message if ENV['DEBUG']
    end

    def error_log(message)
      # Выводим сообщение об ошибке в stderr
      warn message
    end
  end
end
