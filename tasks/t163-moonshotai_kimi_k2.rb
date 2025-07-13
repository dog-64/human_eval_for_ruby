def generate_even_numbers(a, b)
  min = [a, b].min
  max = [a, b].max
  (min..max).select(&:even?)
end