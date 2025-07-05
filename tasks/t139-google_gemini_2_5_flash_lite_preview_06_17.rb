def factorial(num)
  (1..num).reduce(1, :*)
end

def special_factorial(n)
  (1..n).map { |i| factorial(i) }.reduce(1, :*)
end