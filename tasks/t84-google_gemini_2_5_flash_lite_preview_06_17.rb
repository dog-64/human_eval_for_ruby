def sum_binary_digits(n)
  n.to_s.chars.map(&:to_i).sum.to_s(2)
end