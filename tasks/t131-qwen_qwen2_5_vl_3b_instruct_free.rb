def digits(n)
  digits = n.to_s.chars.map(&:to_i)
  product = digits.select { |digit| digit.odd? }.inject(:*)
  product == 0 ? 0 : product
end
