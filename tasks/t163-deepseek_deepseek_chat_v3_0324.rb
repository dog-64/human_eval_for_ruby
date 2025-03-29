def generate_even_numbers(a, b)
  start, finish = [a, b].minmax
  (start..finish).select(&:even?)
end