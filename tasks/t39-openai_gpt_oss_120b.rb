def prime?(num)
  return false if num < 2
  return true if num == 2
  return false if num.even?
  limit = Math.sqrt(num).to_i
  i = 3
  while i <= limit
    return false if num % i == 0
    i += 2
  end
  true
end

def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0
  count = 0
  a = 0
  b = 1
  loop do
    a, b = b, a + b
    next if a < 2
    if prime?(a)
      count += 1
      return a if count == n
    end
  end
end