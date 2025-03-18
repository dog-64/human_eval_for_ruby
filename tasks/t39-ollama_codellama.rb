def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  # Фибоначчи numbers
  fib = [1, 2]

  # Calculate the n-th Fibonacci number
  (3..n).each do |i|
    fib[i] = fib[i - 1] + fib[i - 2]
  end

  # Check if the number is prime
  prime = true
  (2..Math.sqrt(fib[n])).step(1) do |i|
    if fib[n] % i == 0
      prime = false
      break
    end
  end

  if prime
    return fib[n]
  else
    raise ArgumentError, "The number is not a prime Fibonacci number"
  end
end