def generate_even_numbers(a, b)
  min, max = [a, b].minmax
  (min..max).select { |n| n.even? }
end