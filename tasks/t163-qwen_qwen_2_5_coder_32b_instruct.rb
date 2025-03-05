def generate_even_numbers(a, b)
  start_point, end_point = [a, b].minmax
  (start_point..end_point).select { |num| num.even? }
end