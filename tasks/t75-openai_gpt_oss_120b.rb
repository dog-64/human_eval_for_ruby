def is_prime?(n)
  return false if n < 2
  i = 2
  while i * i <= n
    return false if n % i == 0
    i += 1
  end
  true
end

def is_multiply_prime?(a)
  return false if a <= 1
  primes = []
  n = a
  i = 2
  while i * i <= n
    if n % i == 0
      cnt = 0
      while n % i == 0
        n /= i
        cnt += 1
      end
      return false if cnt > 1
      primes << i
    end
    i += 1
  end
  primes << n if n > 1
  primes.size == 3 && primes.uniq.size == 3
end