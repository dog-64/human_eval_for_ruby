def factorize(n)
  return [] if n == 1
  factors = []
  n = -n if n < 0
  factors << -1 if n < 0
  (2..Math.sqrt(n)).each do |i|
    while n % i == 0
      factors << i
      n /= i
    end
  end
  factors << n if n > 1
  factors
end