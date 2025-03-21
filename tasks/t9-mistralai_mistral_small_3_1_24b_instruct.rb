def rolling_max(numbers)
  return [] if numbers.empty?
  result = []
  max_so_far = numbers[0]
  numbers.each do |num|
    max_so_far = [max_so_far, num].max
    result << max_so_far
  end
  result
end