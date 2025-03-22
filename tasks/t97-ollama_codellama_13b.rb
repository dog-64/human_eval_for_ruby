def multiply(a, b)
  a = a.abs
  b = b.abs
  result = 1
  while a > 0 || b > 0
    if a % 10 == 0
      a /= 10
    elsif b % 10 == 0
      b /= 10
    else
      result *= (a % 10) * (b % 10)
      a /= 10
      b /= 10
    end
  end
  return result
end