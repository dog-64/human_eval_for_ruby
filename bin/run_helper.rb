#!/usr/bin/env ruby

require "bundler/setup"
require_relative "../lib/runner/cli"

# Имитируем запуск через файл run вместо run_helper
$0 = File.join(File.dirname($0), 'run')

Runner::CLI.start(ARGV) 
