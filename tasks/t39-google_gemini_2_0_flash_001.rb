def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" if n <= 0

  fib_primes = []
  a, b = 0, 1

  while fib_primes.length < n
    a, b = b, a + b
    if is_prime(b)
      fib_primes << b
    end
  end

  fib_primes[n - 1]
end

def is_prime(num)
  return false if num <= 1
  return true if num == 2
  return false if num % 2 == 0

  (3..Math.sqrt(num).to_i).step(2).each do |i|
    return false if num % i == 0
  end

  true
end