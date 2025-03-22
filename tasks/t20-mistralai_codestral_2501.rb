def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2

  numbers.sort!
  min_diff = Float::INFINITY
  closest_pair = nil

  (0...numbers.size - 1).each do |i|
    diff = numbers[i + 1] - numbers[i]
    if diff < min_diff
      min_diff = diff
      closest_pair = [numbers[i], numbers[i + 1]]
    end
  end

  closest_pair
end