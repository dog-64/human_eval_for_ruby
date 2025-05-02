def sum_binary_digits(n)
  digits = n.to_s.chars.map(&:to_i)
  sum = digits.sum
  sum.to_s(2)
end