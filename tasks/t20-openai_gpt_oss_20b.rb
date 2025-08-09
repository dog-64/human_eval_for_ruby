def find_closest_elements(numbers)
  raise ArgumentError, 'At least two numbers required' if numbers.size < 2
  sorted = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = [sorted[0], sorted[1]]
  (0...(sorted.size - 1)).each do |i|
    diff = (sorted[i + 1] - sorted[i]).abs
    if diff < min_diff
      min_diff = diff
      closest_pair = [sorted[i], sorted[i + 1]]
    end
  end
  closest_pair
end