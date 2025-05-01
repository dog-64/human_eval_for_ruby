def generate_even_numbers(a, b)
  min_val = [a, b].min
  max_val = [a, b].max
  (min_val..max_val).select(&:even?)
end
