def greatest_common_divisor(a, b)
  return 0 if a == 0 && b == 0
  return a.abs if b == 0
  return b.abs if a == 0
  while b != 0
    a, b = b, a % b
  end
  a.abs
end