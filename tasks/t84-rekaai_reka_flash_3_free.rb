
def sum_binary_digits(n)
  sum = n.to_s.chars.map(&:to_i).sum
  sum.to_s(2)
end

 