def is_multiply_prime?(a)
  primes = []
  
  if a <= 1
    return false
  end

  
  i = 2
  while i * i <= a
    while a % i == 0
      primes << i
      a /= i
    end
    i += 1
  end

  
  if a > 1
    primes << a
  end

  
  return primes.length == 3 && primes.uniq.length == 3
end
