def greatest_common_divisor(a, b)
  a = a.abs
  b = b.abs
  return a if b == 0
  greatest_common_divisor(b, a % b)
end