def fix_spaces(text)
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | fix_spaces(#{text})"
  return "" if text.nil?  # Защита от nil
  puts "Input text: #{text.inspect}"  # Отладка
  result = text.gsub(/^ +/) { |s| '_' }  # Заменяем пробелы в начале на один _
           .gsub(/ {3,}/, '-')           # Заменяем 3+ пробела на -
           .gsub(' ', '_')               # Заменяем оставшиеся пробелы на _
  puts "Result: #{result.inspect}"  # Отладка
  result
end
