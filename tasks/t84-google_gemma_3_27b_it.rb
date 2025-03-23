def sum_binary_digits(n)
  sum = 0
  n.to_s.each_char do |digit|
    sum += digit.to_i
  end
  sum.to_s(2)
end