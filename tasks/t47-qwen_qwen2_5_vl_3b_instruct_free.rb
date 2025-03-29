def median(numbers)
  raise ArgumentError, "List is empty" if numbers.empty?

  sorted_numbers = numbers.sort
  count = sorted_numbers.length
  middle_index = count / 2

  if count.odd?
    sorted_numbers[middle_index]
  else
    (sorted_numbers[middle_index - 1] + sorted_numbers[middle_index]) / 2.0
  end
end