def find_closest_elements(numbers)
  raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2
  sorted_numbers = numbers.sort
  best_pair = [sorted_numbers[0], sorted_numbers[1]]
  min_diff = best_pair[1] - best_pair[0]
  sorted_numbers.each_cons(2) do |a, b|
    diff = b - a
    if diff < min_diff
      best_pair = [a, b]
      min_diff = diff
    end
  end
  best_pair
end