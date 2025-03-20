def by_length(arr)
  # Фильтруем массив и сортируем его в порядке убывания
  filtered = arr.select { |num| num >= 1 && num <= 9 }.sort.reverse
  
  # Разворачиваем отсортированный массив
  unpacked = filtered.unpack("A*")
  
  # Заменяем каждое число на его словесное представление
  words = unpacked.map { |num| num.to_s.capitalize }
  
  return words
end