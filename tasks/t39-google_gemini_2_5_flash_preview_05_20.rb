def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" unless n.is_a?(Integer) && n > 0

  primes_found = 0
  a, b = 0, 1

  while primes_found < n
    a, b = b, a + b
    
    if is_prime?(a)
      primes_found += 1
    end
  end
  a
end

def is_prime?(num)
  return false if num < 2
  return true if num == 2

  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end