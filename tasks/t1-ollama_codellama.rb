def separate_paren_groups(paren_string)
  # Игнорируем пробелы в строке
  paren_string = paren_string.gsub(/\s+/, "")

  # Создаем список для результата
  result = []

  # Пока есть скобки в строке, продолжаем разделять их на группы
  while paren_string.include?("()")
    # Находим индекс первой открывающейся скобки
    opening_index = paren_string.index("(")

    # Находим индекс закрывающейся скобки, если она есть
    closing_index = paren_string.rindex(")")

    # Если закрывающаяся скобка есть, то добавляем группу в результат
    if closing_index
      result << paren_string[opening_index..closing_index]

      # Удаляем эту группу из строки
      paren_string = paren_string[0...opening_index] + paren_string[(closing_index + 1)..-1]
    else
      # Если закрывающаяся скобка нет, то добавляем только открывающуюся в результат
      result << paren_string[opening_index..-1]

      # Удаляем эту группу из строки
      paren_string = paren_string[0...opening_index]
    end
  end

  return result
end