#!/usr/bin/env ruby

require_relative "lib/report"

# Проверяем вызов CLI с помощью хелпера
Report.cli(["generate"]) do |result|
  puts "Результат выполнения: #{result ? "успешно" : "ошибка"}"
end 