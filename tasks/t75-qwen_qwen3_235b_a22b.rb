def is_multiply_prime?(a)
  return false if a < 2

  factors = []
  n = a

  while n % 2 == 0
    factors << 2
    n /= 2
  end

  i = 3
  while i * i <= n
    while n % i == 0
      factors << i
      n /= i
    end
    i += 2
  end

  if n > 1
    factors << n
  end

  unique_primes = factors.uniq
  unique_primes.size == 3 && unique_primes.reduce(1, :*) == a
end