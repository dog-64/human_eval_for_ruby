def special_factorial(n)
  result = 1
  running_factorial = 1
  (1..n).each do |i|
    running_factorial *= i
    result *= running_factorial
  end
  result
end