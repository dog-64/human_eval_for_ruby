def generate_even_numbers(a, b)
  start = [a, b].min
  finish = [a, b].max
  (start..finish).select { |num| num.even? }
end