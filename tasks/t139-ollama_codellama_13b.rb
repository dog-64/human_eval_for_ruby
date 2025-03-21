def special_factorial(n)
  return 1 if n == 0
  (n..1).inject(:*)
end