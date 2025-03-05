def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" unless n.is_a?(Integer) && n > 0

  fibs = [0, 1]
  primes = []

  while primes.length < n
    fibs << fibs[-1] + fibs[-2]
    candidate = fibs.last
    primes << candidate if prime?(candidate)
  end

  primes[n - 1]
end

def prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end