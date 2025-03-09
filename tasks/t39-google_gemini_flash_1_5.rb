def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  fib_sequence = [1, 2]
  prime_fib_sequence = [2]

  i = 2
  while prime_fib_sequence.length < n
    next_fib = fib_sequence[i - 1] + fib_sequence[i - 2]
    fib_sequence << next_fib
    prime_fib_sequence << next_fib if is_prime?(next_fib)
    i += 1
  end

  prime_fib_sequence[n-1]
end

def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end
