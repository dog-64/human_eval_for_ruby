def special_factorial(n)
  result = 1
  (1..n).each do |i|
    factorial = 1
    (1..i).each do |j|
      factorial *= j
    end
    result *= factorial
  end
  result
end