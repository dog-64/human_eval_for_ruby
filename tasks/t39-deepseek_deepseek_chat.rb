def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  def is_prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).each do |i|
      return false if num % i == 0
    end
    true
  end

  count = 0
  a, b = 0, 1
  while true
    a, b = b, a + b
    if is_prime?(a)
      count += 1
      return a if count == n
    end
  end
end