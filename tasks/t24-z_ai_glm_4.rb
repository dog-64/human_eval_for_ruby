def largest_divisor(n)
  return nil if n <= 1
  d = 2
  while d * d <= n
    return n / d if n % d == 0
    d += 1
  end
  1
end