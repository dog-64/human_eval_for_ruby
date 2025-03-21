def prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def fibonacci(n)
  return n if n <= 1
  a, b = 0, 1
  (n - 1).times do
    a, b = b, a + b
  end
  b
end

def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" if n <= 0
  count = 0
  i = 0
  while count < n
    fib_num = fibonacci(i)
    count += 1 if prime?(fib_num)
    i += 1
  end
  fibonacci(i - 1)
end