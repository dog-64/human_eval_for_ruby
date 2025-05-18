def multiply(a, b)
  last_digit_a = a.abs % 10
  last_digit_b = b.abs % 10
  last_digit_a * last_digit_b
end