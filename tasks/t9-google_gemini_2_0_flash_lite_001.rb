def rolling_max(numbers)
  return [] if numbers.empty?

  max_so_far = numbers[0]
  result = [max_so_far]

  numbers[1..-1].each do |number|
    max_so_far = [max_so_far, number].max
    result << max_so_far
  end

  result
end