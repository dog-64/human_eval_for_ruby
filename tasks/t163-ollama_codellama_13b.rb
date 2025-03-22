def generate_even_numbers(a, b)
  return [] if a > b || (a == b && !a.even?)

  numbers = (a..b).select { |n| n.even? }
  numbers.sort!
end