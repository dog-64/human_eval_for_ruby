def rescale_to_unit(numbers)
  return [] if numbers.size < 2
  min_value = numbers.min
  max_value = numbers.max
  (numbers - min_value).map { |x| (x - min_value) / (max_value - min_value) }
end