def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2

  sorted_numbers = numbers.sort
  min_distance = Float::INFINITY
  closest_pair = []

  (0...sorted_numbers.size-1).each do |i|
    current_distance = (sorted_numbers[i+1] - sorted_numbers[i]).abs
    if current_distance < min_distance
      min_distance = current_distance
      closest_pair = [sorted_numbers[i], sorted_numbers[i+1]]
    end
  end

  closest_pair
end