def median(numbers)
  raise ArgumentError, "Input must be an array" unless numbers.is_a?(Array)
  raise ArgumentError, "Input array must contain only numbers" unless numbers.all? { |n| n.is_a?(Numeric) }
  return nil if numbers.empty?

  sorted = numbers.sort
  length = sorted.length
  mid = length / 2

  if length.odd?
    sorted[mid]
  else
    (sorted[mid - 1] + sorted[mid]).to_f / 2
  end
end