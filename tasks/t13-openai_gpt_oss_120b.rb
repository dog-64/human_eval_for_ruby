def greatest_common_divisor(a, b)
  a = a.abs
  b = b.abs
  return a if b == 0
  return b if a == 0
  while b != 0
    a, b = b, a % b
  end
  a
end