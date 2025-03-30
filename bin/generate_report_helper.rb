#!/usr/bin/env ruby

require 'bundler/setup'
require_relative '../lib/runner/runner'

# Запускаем тесты и получаем результаты
options = { report: true, log_level: 'normal' }
runner = Runner::Runner.new(options)
results = runner.run_tests

puts "\nОтчеты успешно созданы в каталоге reports/"
puts "Используйте их для анализа результатов тестирования моделей." 