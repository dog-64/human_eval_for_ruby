
def is_multiply_prime?(a)
  return false if a <= 0
  
  primes = []
  n = a
  
  (2..Math.sqrt(a)).each do |i|
    while n % i == 0
      primes << i
      n /= i
    end
  end
  
  if n > 1
    primes << n
  end
  
  if primes.length != 3
    return false
  end
  
  if primes[0] == primes[1] || primes[0] == primes[2] || primes[1] == primes[2]
    return false
  end
  
  
  primes.each do |prime|
    (2..Math.sqrt(prime)).each do |i|
      if prime % i == 0
        return false
      end
    end
  end
  
  return true
end
