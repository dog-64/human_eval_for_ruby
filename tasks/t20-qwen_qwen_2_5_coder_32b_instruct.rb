def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2

  sorted_numbers = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = []

  sorted_numbers.each_cons(2) do |a, b|
    diff = b - a
    if diff < min_diff
      min_diff = diff
      closest_pair = [a, b]
    end
  end

  closest_pair
end