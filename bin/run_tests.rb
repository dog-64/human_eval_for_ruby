#!/usr/bin/env ruby

require "bundler/setup"
require_relative "../lib/test_runner/cli"

# Добавляем опцию --report-total по умолчанию только в production окружении
unless ENV['RACK_ENV'] == 'test'
  ARGV << "--report-total" unless ARGV.any? { |arg| arg.include?("report-total") }
end

TestRunner::CLI.start(ARGV) 