# frozen_string_literal: true

require_relative 'log_levels'

module HumanEval
  module Logger
    include LogLevels

    def log_level
      @log_level ||= LogLevels::INFO
    end

    def log_level=(level)
      @log_level = level
    end

    def debug_log(message)
      log(LogLevels::DEBUG, message)
    end

    def info_log(message)
      log(LogLevels::INFO, message)
    end

    def warning_log(message)
      log(LogLevels::WARNING, message)
    end

    def error_log(message)
      log(LogLevels::ERROR, message)
    end

    private

    def log(level, message)
      return if level < log_level
      puts "[#{level_to_string(level)}] #{message}"
    end

    def level_to_string(level)
      case level
      when LogLevels::DEBUG then 'DEBUG'
      when LogLevels::INFO then 'INFO'
      when LogLevels::WARNING then 'WARNING'
      when LogLevels::ERROR then 'ERROR'
      else 'UNKNOWN'
      end
    end
  end
end 
