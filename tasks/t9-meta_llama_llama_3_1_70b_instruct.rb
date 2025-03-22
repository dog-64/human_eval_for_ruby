def rolling_max(numbers)
  max = -Float::INFINITY
  numbers.map { |n| max = [max, n].max }
end