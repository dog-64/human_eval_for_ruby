def digits(n)
  product = 1
  has_odd = false
  n.to_s.each_char do |char|
    digit = char.to_i
    if digit.odd?
      product *= digit
      has_odd = true
    end
  end
  has_odd ? product : 0
end