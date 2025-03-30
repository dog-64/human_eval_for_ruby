
def generate_even_numbers(a, b)
  min_val = [a, b].min
  max_val = [a, b].max

  first_even = min_val.even? ? min_val : min_val + 1

  return [] if first_even > max_val

  (first_even..max_val).step(2).to_a
end

 