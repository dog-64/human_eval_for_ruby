def digits(n)
  product = 1
  found_odd = false
  n.to_s.chars.each do |char|
    digit = char.to_i
    if digit.odd?
      product *= digit
      found_odd = true
    end
  end
  found_odd ? product : 0
end