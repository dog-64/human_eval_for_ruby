def greatest_common_divisor(a, b)
  return a.abs if b == 0
  greatest_common_divisor(b, a % b)
end