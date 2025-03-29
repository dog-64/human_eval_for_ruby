def rolling_max(numbers)
  return [] if numbers.empty?
  max = numbers.first
  numbers.each_with_object([]) do |num, result|
    max = num if num > max
    result << max
  end
end