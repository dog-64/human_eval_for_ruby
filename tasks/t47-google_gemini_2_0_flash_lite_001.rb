def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" unless numbers.is_a?(Array)

  numbers.each do |num|
    raise ArgumentError, "Array elements must be numbers" unless num.is_a?(Numeric)
  end
  
  return nil if numbers.empty?

  sorted_numbers = numbers.sort
  len = sorted_numbers.length

  if len.odd?
    sorted_numbers[len / 2]
  else
    (sorted_numbers[len / 2 - 1] + sorted_numbers[len / 2]).to_f / 2
  end
end