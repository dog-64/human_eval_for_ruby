def greatest_common_divisor(a, b)
  if a == 0 && b == 0
    return 0
  elsif a == 0
    return b.abs
  elsif b == 0
    return a.abs
  else
    while b != 0
      a, b = b, a % b
    end
    a.abs
  end
end
