def digits(n)
  product = 1
  has_odd = false
  n.digits.each do |d|
    if d.odd?
      product *= d
      has_odd = true
    end
  end
  has_odd ? product : 0
end