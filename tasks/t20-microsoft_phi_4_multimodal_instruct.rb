def find_closest_elements(numbers)
  raise ArgumentError, 'Список должен содержать минимум два числа' if numbers.size < 2

  numbers.sort_by!.each_cons(2).max_by { |a, b| b - a }
end
