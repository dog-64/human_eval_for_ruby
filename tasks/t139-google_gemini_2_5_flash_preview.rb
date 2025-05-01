def special_factorial(n)
  result = 1
  (1..n).each do |i|
    factorial_i = 1
    (1..i).each do |j|
      factorial_i *= j
    end
    result *= factorial_i
  end
  result
end