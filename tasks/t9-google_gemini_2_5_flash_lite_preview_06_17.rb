def rolling_max(numbers)
  return [] if numbers.empty?
  max_so_far = numbers.first
  numbers.map do |num|
    max_so_far = [max_so_far, num].max
    max_so_far
  end
end