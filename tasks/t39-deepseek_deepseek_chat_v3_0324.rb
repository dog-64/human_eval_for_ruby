def prime_fib(n)
  raise ArgumentError, 'n must be positive' unless n.positive?

  fib_primes = []
  a, b = 1, 1

  until fib_primes.size >= n
    a, b = b, a + b
    fib_primes << a if prime?(a)
  end

  fib_primes[n - 1]
end

def prime?(num)
  return false if num <= 1
  return true if num == 2

  (2..Math.sqrt(num).to_i).none? { |i| num % i == 0 }
end