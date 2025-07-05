def sum_binary_digits(n)
  sum_digits = n.to_s.chars.map(&:to_i).sum
  sum_digits.to_s(2)
end