def brazilian_factorial(n)
  return 1 if n == 1
  result = 1
  (1..n).each do |i|
    result *= factorial(i)
  end
  result
end

def factorial(n)
  return 1 if n == 1
  (1..n).inject(:*)
end
