def rescale_to_unit(numbers)
  return [] if numbers.length < 2

  min = numbers.min
  max = numbers.max
  range = max - min

  numbers.map do |num|
    (num - min) / range
  end
end