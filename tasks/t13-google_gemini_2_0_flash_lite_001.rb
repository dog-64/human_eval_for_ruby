def greatest_common_divisor(a, b)
  if b == 0
    a.abs
  elsif a == 0
    b.abs
  else
    while b != 0
      a, b = b, a % b
    end
    a.abs
  end
end