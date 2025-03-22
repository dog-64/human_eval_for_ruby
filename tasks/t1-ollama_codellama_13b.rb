def separate_paren_groups(paren_string)
  # Игнорируем пробелы в строке
  paren_string = paren_string.gsub(/\s+/, "")

  # Создаем список для результата
  result = []

  # Проходим по всем символам входной строки
  paren_string.chars.each do |char|
    # Если встретили открывающуюся скобку, добавляем ее в список
    if char == "("
      result << ""
    # Если встретили закрывающуюся скобку, добавляем ее в список и удаляем последний элемент
    elsif char == ")"
      result.pop
    # Если встретили пробел, игнорируем его
    elsif char == " "
      next
    end
  end

  # Возвращаем результат
  return result
end