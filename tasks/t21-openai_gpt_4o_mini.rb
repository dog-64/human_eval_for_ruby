def rescale_to_unit(numbers)
  raise ArgumentError, "Список должен содержать как минимум два элемента" if numbers.size < 2

  min = numbers.min
  max = numbers.max
  range = max - min

  numbers.map { |num| (num - min) / range }
end