def greatest_common_divisor(a, b)
  while b != 0
    a, b = b, a % b
  end
  a.abs
end