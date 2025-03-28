def separate_paren_groups(paren_string)
  paren_string = paren_string.gsub(/\s/, '') # Игнорируем пробелы
  result = []
  current_group = ''
  balance = 0

  paren_string.each_char do |char|
    if char == '('
      balance += 1
      current_group += char
    elsif char == ')'
      balance -= 1
      current_group += char
    end

    if balance == 0 && current_group.length > 0
      result << current_group
      current_group = ''
    end
  end

  result
end