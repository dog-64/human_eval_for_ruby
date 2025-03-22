def factorize(n)
  return [] if n == 1
  factors = []
  (2..Math.sqrt(n)).step(1) do |i|
    while n % i == 0
      factors << i
      n /= i
    end
  end
  factors << n if n > 1
  return factors
end