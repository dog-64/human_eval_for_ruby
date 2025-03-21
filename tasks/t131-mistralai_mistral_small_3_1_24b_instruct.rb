def digits(n)
  product = 1
  has_odd_digit = false

  n.digits.each do |digit|
    if digit.odd?
      product *= digit
      has_odd_digit = true
    end
  end

  has_odd_digit ? product : 0
end