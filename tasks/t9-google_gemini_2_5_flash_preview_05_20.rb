def rolling_max(numbers)
  return [] if numbers.empty?

  max_so_far = -Float::INFINITY
  result = []
  numbers.each do |num|
    max_so_far = [max_so_far, num].max
    result << max_so_far
  end
  result
end