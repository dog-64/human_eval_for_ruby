def reverse_delete(s, c)
  # удаляем символы из s, которые присутствуют в c
  result = s.gsub(/[#{c}]/, '')

  # проверяем, является ли результирующая строка палиндромом
  palindrome = result == result.reverse

  return [result, palindrome]
end
