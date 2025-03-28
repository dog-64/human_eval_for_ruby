def generate_even_numbers(a, b)
  (a..b).select { |num| num.even? }.sort
end