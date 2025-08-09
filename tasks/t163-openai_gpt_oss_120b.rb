def generate_even_numbers(a, b)
  low, high = [a, b].minmax
  start = low.even? ? low : low + 1
  return [] if start > high
  (start..high).step(2).to_a
end