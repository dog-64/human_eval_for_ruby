def generate_even_numbers(a, b)
  start, stop = [a, b].min, [a, b].max
  (start..stop).select { |n| n.even? }
end