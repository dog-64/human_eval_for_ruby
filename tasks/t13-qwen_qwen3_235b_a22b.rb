def greatest_common_divisor(a, b)
  if a == 0 && b == 0
    0
  elsif a == 0
    b.abs
  elsif b == 0
    a.abs
  else
    a = a.abs
    b = b.abs
    while b != 0
      a, b = b, a % b
    end
    a
  end
end