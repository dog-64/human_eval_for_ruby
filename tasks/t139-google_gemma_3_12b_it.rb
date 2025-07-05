def special_factorial(n)
  result = 1
  n.times do |i|
    result *= factorial(i + 1)
  end
  result
end

def factorial(n)
  fact = 1
  (1..n).each { |i| fact *= i }
  fact
end
