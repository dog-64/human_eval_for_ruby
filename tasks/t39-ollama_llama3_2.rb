def prime_fib(n)
  fib = [0, 1]
  while (fib[-1] + fib[-2]) < n
    fib << fib[-1] + fib[-2]
  end
  fib.select { |x| x.prime? && x >= n }.first
end

def prime?(n)
  if n <= 1
    return false
  end
  for i in 2..Math.sqrt(n).to_i
    break unless n % i == 0
  end
  true
end