def sum_binary_digits(n)
  sum = n.digits.sum
  sum.to_s(2)
end