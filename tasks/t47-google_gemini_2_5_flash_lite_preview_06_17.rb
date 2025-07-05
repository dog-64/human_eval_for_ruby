def median(numbers)
  raise ArgumentError, "Input must be an array of numbers" if !numbers.is_a?(Array)
  raise ArgumentError, "Input array cannot be empty" if numbers.empty?
  numbers.each do |num|
    raise ArgumentError, "All elements must be numbers" unless num.is_a?(Numeric)
  end

  sorted_numbers = numbers.sort
  n = sorted_numbers.length
  mid = n / 2

  if n.odd?
    sorted_numbers[mid]
  else
    (sorted_numbers[mid - 1] + sorted_numbers[mid]).to_f / 2
  end
end