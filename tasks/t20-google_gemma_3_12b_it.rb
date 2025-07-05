def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.length < 2

  numbers.sort!
  min_diff = Float::INFINITY
  closest_pair = [numbers[0], numbers[1]]

  (0...numbers.length - 1).each do |i|
    diff = numbers[i+1] - numbers[i]
    if diff < min_diff
      min_diff = diff
      closest_pair = [numbers[i], numbers[i+1]]
    end
  end

  closest_pair
end
