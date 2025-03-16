def prime_fib(n)
  raise ArgumentError, 'Input must be a positive integer' if n <= 0

  fibs = [0, 1]
  primes = []
  
  def is_prime(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  while primes.size < n
    fibs << fibs[-1] + fibs[-2]
    primes << fibs.last if is_prime(fibs.last)
  end

  primes[n - 1]
end