def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.length < 2

  min_diff = Float::INFINITY
  closest_pair = nil

  numbers.combination(2).each do |pair|
    diff = (pair[1] - pair[0]).abs
    if diff < min_diff
      min_diff = diff
      closest_pair = pair.sort
    end
  end

  closest_pair
end
