def fruit_distribution(fruit_string, total_fruits)
  # Разбиваем строку на массив с количеством яблок и апельсинов
  fruits = fruit_string.split(" and ")

  # Извлекаем количество яблок и апельсинов из массива
  apples = fruits[0].to_i
  oranges = fruits[1].to_i

  # Вычисляем общее количество фруктов
  total_fruits = apples + oranges

  # Если общее количество фруктов меньше или равно количеству манго, возвращаем 0
  if total_fruits <= total_fruits - apples
    return 0
  end

  # Вычисляем количество манго и возвращаем его
  mangoes = total_fruits - apples - oranges
  return mangoes
end