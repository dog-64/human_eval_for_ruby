def special_factorial(n)
  result = 1
  factorial = 1
  (1..n).each do |i|
    factorial *= i
    result *= factorial
  end
  result
end