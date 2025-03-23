# frozen_string_literal: true

require_relative 'log_levels'

module HumanEval
  module Logger
    include LogLevels

    def log_level
      @log_level ||= LogLevels::INFO
    end

    def log_level=(level)
      @log_level = case level
      when :debug, 'debug' then LogLevels::DEBUG
      when :normal, 'normal', :info, 'info' then LogLevels::INFO
      when :warning, 'warning' then LogLevels::WARNING
      when :error, 'error' then LogLevels::ERROR
      when Integer then level
      else LogLevels::INFO
      end
    end

    def debug_log(message)
      log(LogLevels::DEBUG, message)
    end
    alias debug debug_log

    def info_log(message)
      log(LogLevels::INFO, message)
    end
    alias info info_log

    def warning_log(message)
      log(LogLevels::WARNING, message)
    end
    alias warning warning_log

    def error_log(message)
      log(LogLevels::ERROR, message)
    end
    alias error error_log

    private

    def log(level = LogLevels::INFO, message)
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
