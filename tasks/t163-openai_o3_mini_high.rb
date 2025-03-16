def generate_even_numbers(a, b)
  low, high = [a, b].min, [a, b].max
  first = low.even? ? low : low + 1
  return [] if first > high
  (first..high).step(2).to_a
end