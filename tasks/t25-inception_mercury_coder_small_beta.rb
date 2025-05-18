def factorize(n)
  factors = []
  if n < 0
    factors << -1
    n = -n
  end
  (2..n).each do |i|
    while n % i == 0
      factors << i
      n /= i
    end
  end
  factors
end