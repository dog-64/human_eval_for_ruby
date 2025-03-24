def sum_binary_digits(n)
  sum = n.to_s(2).count('1')
  sum.to_s(2)
end
