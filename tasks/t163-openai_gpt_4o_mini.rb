def generate_even_numbers(a, b)
  range = [a, b].min..[a, b].max
  range.select { |num| num.even? }
end