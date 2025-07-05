def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" if n <= 0

  def fibonacci_sequence(limit)
    a, b = 0, 1
    sequence = []
    until b > limit
      sequence << b
      a, b = b, a + b
    end
    sequence
  end

  def is_prime?(num)
    return false if num <= 1
    return true if num == 2
    return false if num % 2 == 0
    (3..Math.sqrt(num)).step(2) do |i|
      return false if num % i == 0
    end
    true
  end

  fib_numbers = fibonacci_sequence(100000) # Adjust limit as needed
  prime_fib_numbers = fib_numbers.select { |num| is_prime?(num) }

  prime_fib_numbers[n - 1]
end
