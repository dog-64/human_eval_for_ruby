def separate_paren_groups(paren_string)
  paren_string = paren_string.gsub(/\s/, '') # Игнорируем пробелы
  result = []
  stack = []
  paren_string.each_char do |char|
    if char == '('
      stack.push(char)
    elsif char == ')' && !stack.empty?
      result << stack.join
      stack.pop
    end
  end
  result << stack.join if !stack.empty? # Добавляем оставшиеся скобки
  result
end
