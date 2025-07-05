def special_factorial(n)
  result = 1
  (1..n).each do |i|
    result *= factorial(i)
  end
  result
end

def factorial(n)
  if n == 0
    1
  else
    result = 1
    (1..n).each do |i|
      result *= i
    end
    result
  end
end
