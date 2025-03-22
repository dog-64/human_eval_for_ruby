def prime_fib(n)
  raise ArgumentError, 'n must be a positive integer' unless n.is_a?(Integer) && n > 0

  def is_prime(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  fib = [0, 1]
  prime_count = 0

  while prime_count < n
    fib.push(fib[-1] + fib[-2])
    prime_count += 1 if is_prime(fib.last)
  end

  fib.last
end