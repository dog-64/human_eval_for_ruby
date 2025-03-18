def greatest_common_divisor(a, b)
  return a if b == 0
  return b if a == 0
  a % b < b ? a : greatest_common_divisor(b, a % b)
end