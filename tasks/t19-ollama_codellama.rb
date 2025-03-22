def sort_numbers(numbers)
  # Разделяем строку на массив чисел
  numbers = numbers.split(" ")

  # Сортируем массив чисел
  numbers.sort! do |a, b|
    a.to_i <=> b.to_i
  end

  # Возвращаем отсортированную строку
  return numbers.join(" ")
end