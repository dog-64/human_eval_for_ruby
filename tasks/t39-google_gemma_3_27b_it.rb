def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" if n <= 0

  count = 0
  a, b = 0, 1

  while count < n
    a, b = b, a + b
    if prime?(b)
      count += 1
    end
  end

  return a
end

def prime?(num)
  return false if num <= 1
  return true if num <= 3
  return false if num % 2 == 0 || num % 3 == 0

  i = 5
  while i * i <= num
    return false if num % i == 0 || num % (i + 2) == 0
    i += 6
  end

  return true
end