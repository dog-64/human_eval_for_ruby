
greatest_common_divisor(a, b)
  a = a.abs
  b = b.abs

  while b != 0
    a, b = b, a % b
  end

  a
end