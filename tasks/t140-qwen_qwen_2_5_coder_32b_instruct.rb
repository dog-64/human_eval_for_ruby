def fix_spaces(text)
  puts "#{__FILE__}:#{__LINE__} [DEBUG] | fix_spaces(#{text})"
  return "" if text.nil?  # Защита от nil
  puts "Input text: #{text.inspect}"  # Отладка
  result = text.gsub(/ {3,}/, '-').gsub(' ', '_')
  puts "Result: #{result.inspect}"  # Отладка
  result
end
