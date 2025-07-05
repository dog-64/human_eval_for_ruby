def generate_even_numbers(a, b)
  min_val, max_val = [a, b].minmax
  (min_val..max_val).select(&:even?)
end