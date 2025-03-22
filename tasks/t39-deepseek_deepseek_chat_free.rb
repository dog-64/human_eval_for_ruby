def prime_fib(n)
  raise ArgumentError, "n must be a positive integer" unless n.is_a?(Integer) && n > 0

  fib = [0, 1]
  prime_count = 0
  result = nil

  while prime_count < n
    fib << fib[-1] + fib[-2]
    num = fib[-1]
    if num >= 2 && (2..Math.sqrt(num)).none? { |i| num % i == 0 }
      prime_count += 1
      result = num
    end
  end
  result
end