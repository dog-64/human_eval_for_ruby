def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" if n <= 0

  fib_numbers = []
  a, b = 0, 1

  while fib_numbers.length < n
    a, b = b, a + b
    fib_numbers << b
  end

  fib_numbers[n - 1]
end
