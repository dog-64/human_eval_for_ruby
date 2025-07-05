def generate_even_numbers(a, b)
  start = [a, b].min
  end_val = [a, b].max
  (start..end_val).select(&:even?)
end