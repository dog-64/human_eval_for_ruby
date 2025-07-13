def prime_fib(n)
  raise ArgumentError, "n must be positive" if n < 1

  prime?(num) = (2..Math.sqrt(num)).none? { |i| num % i == 0 }

  fib_primes = []
  a, b = 0, 1

  while fib_primes.size < n
    a, b = b, a + b
    fib_primes << b if b > 1 && prime?(b)
  end

  fib_primes.last
end