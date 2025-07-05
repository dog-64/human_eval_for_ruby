def sum_binary_digits(n)
  sum_of_digits = n.to_s.chars.map(&:to_i).sum
  sum_of_digits.to_s(2)
end
