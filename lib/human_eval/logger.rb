# frozen_string_literal: true

require 'terminal-table'
require 'pry'
require 'timeout'

module HumanEval
  module Logger
    LOG_LEVELS = {
      none: 0,
      error: 1,
      normal: 2,
      debug: 3
    }.freeze

    def self.included(base)
      base.instance_variable_set(:@log_level, LOG_LEVELS[:normal])
    end

    def log_level=(level)
      @log_level = if level.is_a?(Symbol)
                     LOG_LEVELS[level] || LOG_LEVELS[:normal]
                   else
                     LOG_LEVELS[level.to_sym] || LOG_LEVELS[:normal]
                   end
    end

    def log(message, level = :normal, depth = 1)
      return if @log_level < LOG_LEVELS[level]

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

    def debug(message)
      log(message, :debug, 2)
    end

    def error(message)
      log(message, :error, 2)
    end
  end
end
