def special_factorial(n)
  (1..n).map { |i| (1..i).reduce(1, :*) }.reduce(1, :*)
end