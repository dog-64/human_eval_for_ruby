def rescale_to_unit(numbers)
  # проверяем, что входной список содержит как минимум два элемента
  if numbers.size < 2
    raise ArgumentError, "Input list must contain at least two elements"
  end

  # находим максимальное и минимальное значения входного списка
  min_value = numbers.min
  max_value = numbers.max

  # вычисляем разницу между максимальным и минимальным значением
  range = max_value - min_value

  # возвращаем новый список, где каждое значение линейно масштабировано в диапазон [0, 1]
  return numbers.map { |x| (x - min_value) / range }
end