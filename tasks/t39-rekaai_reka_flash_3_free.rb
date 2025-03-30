
def is_prime?(num)
  return false if num <= 1
  return true if num <= 3
  return false if num % 2 == 0 || num % 3 == 0
  i = 5
  w = 2
  while i * i <= num
    if num % i == 0
      return false
    end
    i += w
    w = 6 - w
  end
  true
end

def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  primes_fib = []
  a, b = 1, 1

  until primes_fib.size == n
    a, b = b, a + b
    next unless is_prime?(b)
    primes_fib << b
  end

  primes_fib.last
end

 