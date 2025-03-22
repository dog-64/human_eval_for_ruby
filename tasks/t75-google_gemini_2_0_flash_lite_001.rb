def is_multiply_prime?(a)
  return false if a <= 1
  primes = []
  d = 2
  temp = a
  while d * d <= temp
    if temp % d == 0
      primes << d
      while temp % d == 0
        temp /= d
      end
    end
    d += 1
  end
  primes << temp if temp > 1
  return false if primes.length != 3
  primes.all? { |p| (2..Math.sqrt(p)).none? { |i| p % i == 0 } }
end