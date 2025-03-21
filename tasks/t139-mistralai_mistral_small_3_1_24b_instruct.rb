def special_factorial(n)
  (1..n).inject(1) { |acc, i| acc * i.factorial }
end