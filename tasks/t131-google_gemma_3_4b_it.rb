def digits(n)
  product = 1
  odd_found = false

  n.to_s.each_char do |char|
    digit = char.to_i
    if digit % 2 != 0
      product *= digit
      odd_found = true
    end
  end

  if odd_found
    product
  else
    0
  end
end
