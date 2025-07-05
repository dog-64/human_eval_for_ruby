def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" unless numbers.is_a?(Array)

  if numbers.empty?
    raise ArgumentError, "Input array cannot be empty"
  end

  numbers.each do |num|
    raise ArgumentError, "Array must contain only numbers" unless num.is_a?(Numeric)
  end

  sorted_numbers = numbers.sort
  n = sorted_numbers.length

  if n.odd?
    sorted_numbers[n / 2].to_f
  else
    (sorted_numbers[n / 2 - 1] + sorted_numbers[n / 2]) / 2.0
  end
end