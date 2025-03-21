def factorize(n)
  return [] if n == 1
  return [-1, *factorize(-n)] if n < 0

  factors = []
  divisor = 2

  while n > 1
    while n % divisor == 0
      factors << divisor
      n /= divisor
    end
    divisor += 1
  end

  factors
end