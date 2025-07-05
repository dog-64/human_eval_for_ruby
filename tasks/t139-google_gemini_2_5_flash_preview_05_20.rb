def special_factorial(n)
  result = 1
  (1..n).each do |i|
    factorial_i = (1..i).reduce(1, :*)
    result *= factorial_i
  end
  result
end