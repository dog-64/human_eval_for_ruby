def digits(n)
  product = 1
  has_odd = false
  n.to_s.each_char do |c|
    d = c.ord - 48
    if d.odd?
      product *= d
      has_odd = true
    end
  end
  has_odd ? product : 0
end