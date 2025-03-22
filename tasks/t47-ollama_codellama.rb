def median(numbers)
  raise ArgumentError, "empty list" if numbers.empty?

  sorted_numbers = numbers.sort
  length = sorted_numbers.length

  if length % 2 == 0
    (sorted_numbers[length / 2 - 1] + sorted_numbers[length / 2]) / 2.0
  else
    sorted_numbers[length / 2]
  end
end