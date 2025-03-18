module HumanEval
  module LogLevels
    def debug_log(message)
      return unless @options[:log_level] == :debug || (respond_to?(:log_level) && log_level == :debug)
      debug(message)
    end

    def error_log(message)
      return unless @options[:log_level] == :error || (respond_to?(:log_level) && log_level == :error)
      error(message)
    end
  end
end 