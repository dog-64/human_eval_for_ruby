
def special_factorial(n)
  result = 1
  current_factorial = 1
  (1..n).each do |i|
    current_factorial *= i
    result *= current_factorial
  end
  result
end