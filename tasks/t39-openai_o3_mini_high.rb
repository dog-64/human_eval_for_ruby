def is_prime?(num)
  return false if num < 2
  return true if num == 2
  return false if num.even?
  limit = Math.sqrt(num).to_i
  (3..limit).step(2) do |i|
    return false if num % i == 0
  end
  true
end

def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0
  count = 0
  a, b = 1, 1
  loop do
    a, b = b, a + b
    if is_prime?(a)
      count += 1
      return a if count == n
    end
  end
end