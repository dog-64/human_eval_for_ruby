def find_closest_elements(numbers)
  raise ArgumentError, "Input list must contain at least two numbers" if numbers.length < 2

  sorted_numbers = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = []

  (0...sorted_numbers.length - 1).each do |i|
    diff = sorted_numbers[i + 1] - sorted_numbers[i]
    if diff < min_diff
      min_diff = diff
      closest_pair = [sorted_numbers[i], sorted_numbers[i + 1]]
    end
  end

  closest_pair
end
