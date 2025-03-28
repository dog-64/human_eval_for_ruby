def find_closest_elements(numbers)
  raise ArgumentError, "Input must contain at least two numbers" if numbers.size < 2

  closest_pair = nil
  min_distance = Float::INFINITY

  numbers.combination(2).each do |a, b|
    distance = (a - b).abs
    if distance < min_distance
      min_distance = distance
      closest_pair = [a, b].sort
    end
  end

  closest_pair
end