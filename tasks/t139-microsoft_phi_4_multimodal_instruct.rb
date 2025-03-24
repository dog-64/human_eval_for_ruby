def special_factorial(n)
  return 1 if n <= 1
  factorial = 1
  (1..n).each do |i|
    factorial *= i
  end
  factorial
end