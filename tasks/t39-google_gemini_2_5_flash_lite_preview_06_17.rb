def is_prime(num)
  return false if num < 2
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  fib_sequence = [0, 1]
  prime_fib_count = 0
  current_fib_index = 1

  while prime_fib_count < n
    next_fib = fib_sequence[current_fib_index] + fib_sequence[current_fib_index - 1]
    fib_sequence << next_fib
    current_fib_index += 1

    if is_prime(next_fib)
      prime_fib_count += 1
      return next_fib if prime_fib_count == n
    end
  end
end