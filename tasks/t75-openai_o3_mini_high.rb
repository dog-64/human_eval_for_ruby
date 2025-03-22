def is_multiply_prime?(a)
  return false if a <= 1
  n = a
  factors = []
  d = 2
  while d * d <= n
    while n % d == 0
      factors << d
      n /= d
    end
    d += 1
  end
  factors << n if n > 1
  factors.size == 3 && factors.uniq.size == 3
end