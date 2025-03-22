def special_factorial(n)
  (1..n).map { |i| (1..i).inject(1, :*) }.inject(1, :*)
end