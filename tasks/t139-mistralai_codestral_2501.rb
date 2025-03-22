def special_factorial(n)
  (1..n).inject(1) { |product, i| product * (1..i).inject(1) { |fact, j| fact * j } }
end