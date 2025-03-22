def special_factorial(n)
  return 1 if n == 1
  result = 1
  (1..n).each do |i|
    factorial = (1..i).inject(:*)
    result *= factorial
  end
  result
end
