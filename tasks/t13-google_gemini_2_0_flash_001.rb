def greatest_common_divisor(a, b)
  while(b)
    a, b = b, a % b
  end
  a.abs
end