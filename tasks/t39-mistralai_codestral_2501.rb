def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  def fibonacci(n)
    fibs = [0, 1]
    while fibs.size <= n
      fibs << fibs[-1] + fibs[-2]
    end
    fibs[n]
  end

  def prime?(num)
    return false if num <= 1
    (2..Math.sqrt(num)).each do |i|
      return false if num % i == 0
    end
    true
  end

  count = 0
  i = 1
  while count < n
    fib = fibonacci(i)
    count += 1 if prime?(fib)
    i += 1
  end
  fibonacci(i - 1)
end