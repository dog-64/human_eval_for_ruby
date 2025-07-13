def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2
  
  sorted = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = nil
  
  (0...sorted.size - 1).each do |i|
    diff = sorted[i + 1] - sorted[i]
    if diff < min_diff
      min_diff = diff
      closest_pair = [sorted[i], sorted[i + 1]]
    end
  end
  
  closest_pair
end