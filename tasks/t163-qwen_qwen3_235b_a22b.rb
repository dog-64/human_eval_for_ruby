def generate_even_numbers(a, b)
  start = [a, b].min
  finish = [a, b].max
  (start..finish).select(&:even?)
end