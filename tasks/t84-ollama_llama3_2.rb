def sum_binary_digits(n)
  s = n.to_s(2).reverse
  s.chars.map(&:to_i).sum.to_s(2)
end