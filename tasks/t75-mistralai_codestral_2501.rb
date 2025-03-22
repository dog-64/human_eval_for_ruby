def is_multiply_prime?(a)
  return false if a < 2

  primes = []
  (2..Math.sqrt(a)).each do |i|
    while a % i == 0
      primes << i
      a /= i
    end
  end
  primes << a if a > 1

  primes.uniq.size == 3
end