
def generate_even_numbers(a, b)
  start = [a, b].min
  end = [a, b].max
  (start..end).select { |num| num.even? }
end