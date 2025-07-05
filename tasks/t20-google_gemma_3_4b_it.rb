def find_closest_elements(numbers)
  if numbers.length < 2
    raise ArgumentError, "List must contain at least two numbers"
  end

  sorted_numbers = numbers.sort
  min_diff = Float::INFINITY
  closest_pair = []

  sorted_numbers.each_with_index do |num, index|
    next_index = index + 1
    if next_index < sorted_numbers.length
      diff = sorted_numbers[next_index] - num
      if diff < min_diff
        min_diff = diff
        closest_pair = [num, sorted_numbers[next_index]]
      elsif diff == min_diff && num < closest_pair[0]
        closest_pair = [num, sorted_numbers[next_index]]
      end
    end
  end

  closest_pair
end
