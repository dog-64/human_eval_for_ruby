def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  def prime?(num)
    return false if num <= 1
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  def fibonacci(num)
    a, b = 0, 1
    num.times { a, b = b, a + b }
    a
  end

  count = 0
  i = 0
  while true
    fib_num = fibonacci(i)
    count += 1 if prime?(fib_num)
    return fib_num if count == n
    i += 1
  end
end