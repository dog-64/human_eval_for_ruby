def median(numbers)
  return nil if numbers.empty?

  sorted_numbers = numbers.sort
  mid = sorted_numbers.length / 2

  if sorted_numbers.length.even?
    (sorted_numbers[mid - 1] + sorted_numbers[mid]) / 2.0
  else
    sorted_numbers[mid]
  end
end