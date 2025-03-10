def find_closest_elements(numbers)
  raise ArgumentError, "Input list must contain at least two numbers" if numbers.length < 2

  sorted_numbers = numbers.sort
  min_difference = Float::INFINITY
  closest_pair = []

  (0..sorted_numbers.length - 2).each do |i|
    difference = (sorted_numbers[i+1] - sorted_numbers[i]).abs
    if difference < min_difference
      min_difference = difference
      closest_pair = [sorted_numbers[i], sorted_numbers[i+1]]
    end
  end

  closest_pair
end