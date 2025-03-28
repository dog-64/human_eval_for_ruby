def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end

def prime_fib(n)
  fib = [0, 1]
  while fib.length <= n
    fib << fib[-1] + fib[-2]
  end
  fib[n].to_i
end

def prime_fib(n)
  return nil if n <= 0
  fib = [0, 1]
  while fib.length <= n
    fib << fib[-1] + fib[-2]
  end
  fib[n].to_i if is_prime?(fib[n])
end