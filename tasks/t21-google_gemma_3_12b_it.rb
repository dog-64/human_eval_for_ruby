def rescale_to_unit(numbers)
  raise ArgumentError, "Список должен содержать как минимум два элемента" if numbers.length < 2

  min_val = numbers.min
  max_val = numbers.max

  if min_val == max_val
    return numbers.map { |num| 0.0 }
  end

  numbers.map { |num| (num - min_val) / (max_val - min_val) }
end
