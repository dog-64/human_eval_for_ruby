def sum_binary_digits(n)
  sum = n.to_s(2).chars.map(&:to_i).sum
  "0b#{sum.to_s(2)}"
end