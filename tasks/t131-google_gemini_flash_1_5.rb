def digits(n)
  product = 1
  odd_found = false
  n.to_s.each_char do |digit|
    digit_int = digit.to_i
    if digit_int % 2 != 0
      product *= digit_int
      odd_found = true
    end
  end
  odd_found ? product : 0
end
