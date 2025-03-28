def factorize(n)
  result = []
  (2..n).each do |i|
    while n % i == 0
      result << i
      n /= i
    end
  end
  result
end