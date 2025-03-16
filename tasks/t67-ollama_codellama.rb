def fruit_distribution(fruit_string, total_fruits)
  # Разбиваем строку на массив с количеством яблок и апельсинов
  fruits = fruit_string.split(" and ")
  
  # Извлекаем количество яблок и апельсинов из массива
  apples = fruits[0].to_i
  oranges = fruits[1].to_i
  
  # Вычисляем общее количество фруктов
  total = apples + oranges
  
  # Если общее количество фруктов меньше или равно общему количеству фруктов, возвращаем 0
  return 0 if total <= total_fruits
  
  # Вычисляем количество манго
  mangos = total - total_fruits
  
  # Возвращаем результат
  mangos
end