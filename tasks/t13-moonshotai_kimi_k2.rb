def greatest_common_divisor(a, b)
  return a.abs if b == 0
  return b.abs if a == 0
  a, b = a.abs, b.abs
  while b != 0
    a, b = b, a % b
  end
  a
end