def find_closest_elements(numbers)
  raise ArgumentError, 'Список должен содержать минимум два числа' if numbers.size < 2
  
  sorted = numbers.sort
  closest_pair = [sorted[0], sorted[1]]
  min_diff = (sorted[1] - sorted[0]).abs

  (1...sorted.size).each do |i|
    diff = (sorted[i] - sorted[i - 1]).abs
    if diff < min_diff
      min_diff = diff
      closest_pair = [sorted[i - 1], sorted[i]]
    end
  end

  closest_pair
end