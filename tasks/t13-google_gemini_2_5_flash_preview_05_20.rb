def greatest_common_divisor(a, b)
  a = a.abs
  b = b.abs

  if a == 0 && b == 0
    return 0
  elsif a == 0
    return b
  elsif b == 0
    return a
  end

  while b != 0
    a, b = b, a % b
  end
  a
end