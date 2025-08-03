
def prime_fib(n)
  raise ArgumentError, "n must be positive" if n <= 0

  def prime?(num)
    return false if num < 2
    return true if num == 2
    return false if num.even?

    limit = Math.sqrt(num).to_i + 1
    divisor = 3
    while divisor <= limit
      return false if num % divisor == 0
      divisor += 2
    end
    true
  end

  prime_fibs = []
  a, b = 0, 1

  while prime_fibs.size < n
    c = a + b
    a, b = b, c
    next if c < 2

    prime_fibs << c if prime?(c)
  end

  prime_fibs.last
end