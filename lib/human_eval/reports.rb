# frozen_string_literal: true

require_relative 'reports/cli'
require_relative 'reports/generator'
require_relative 'reports/formatters/base'
require_relative 'reports/formatters/html'
require_relative 'reports/formatters/markdown'

module HumanEval
  # Модуль для генерации отчетов о тестировании моделей
  module Reports
    class Error < StandardError; end
  end
end 