def special_factorial(n)
  (1..n).reduce(1) { |product, i| product * (1..i).reduce(1, :*) }
end