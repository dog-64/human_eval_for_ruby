def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  # Фибоначчи numbers
  fib = [1, 2]

  # Generate Fibonacci sequence until we reach the n-th number
  while fib.last < n
    fib << fib[-1] + fib[-2]
  end

  # Check if the last number in the sequence is prime
  if Prime.prime?(fib.last)
    return fib.last
  else
    raise "No prime Fibonacci number found for n = #{n}"
  end
end