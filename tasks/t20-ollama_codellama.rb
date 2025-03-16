def find_closest_elements(numbers)
  # проверяем, что список содержит минимум два числа
  if numbers.size < 2
    raise ArgumentError, "The list must contain at least two elements"
  end

  # находим минимальное и максимальное значение в списке
  min = numbers.min
  max = numbers.max

  # находим ближайшие числа
  closest_numbers = []
  (min..max).each do |number|
    if numbers.include?(number)
      closest_numbers << number
    end
  end

  # сортируем найденные числа по возрастанию
  closest_numbers.sort!

  # возвращаем кортеж из двух ближайших чисел
  return closest_numbers[0..1]
end
