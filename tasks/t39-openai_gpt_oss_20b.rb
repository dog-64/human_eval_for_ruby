def prime_fib(n)
  raise ArgumentError, 'n must be a positive integer' unless n.is_a?(Integer) && n > 0

  def is_prime?(num)
    return false if num < 2
    return true if num == 2
    return false if num.even?
    i = 3
    while i * i <= num
      return false if num % i == 0
      i += 2
    end
    true
  end

  count = 0
  fib_prev = 1
  fib_curr = 1
  loop do
    fib_next = fib_prev + fib_curr
    fib_prev = fib_curr
    fib_curr = fib_next
    next unless is_prime?(fib_curr)
    count += 1
    return fib_curr if count == n
  end
end