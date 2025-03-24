def generate_even_numbers(a, b)
  (a..b).select(&:even?).sort
end