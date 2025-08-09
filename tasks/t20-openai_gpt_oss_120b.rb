def find_closest_elements(numbers)
  raise ArgumentError, "At least two numbers required" if numbers.size < 2
  sorted = numbers.sort
  min_diff = Float::INFINITY
  result = [sorted[0], sorted[1]]
  (0...sorted.size - 1).each do |i|
    a = sorted[i]
    b = sorted[i + 1]
    diff = (b - a).abs
    if diff < min_diff
      min_diff = diff
      result = [a, b]
    end
  end
  result
end