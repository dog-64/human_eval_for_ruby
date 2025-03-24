require 'prime'

def prime_fib(n)
  raise ArgumentError, 'n must be a positive integer' unless n.is_a?(Integer) && n > 0

  fib_prime = 0
  a, b = 0, 1
  count = 0

  while count < n
    a, b = b, a + b
    count += 1 if a.prime?
    fib_prime = a if a.prime?
  end

  fib_prime
end