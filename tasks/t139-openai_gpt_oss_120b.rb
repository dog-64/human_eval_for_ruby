def special_factorial(n)
  result = 1
  fact = 1
  (1..n).each do |i|
    fact *= i
    result *= fact
  end
  result
end