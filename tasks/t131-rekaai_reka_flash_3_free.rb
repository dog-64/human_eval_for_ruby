
def digits(n)
  product = 1
  n.to_s.chars.each do |c|
    digit = c.to_i
    product *= digit if digit.odd?
  end
  product.zero? ? product : 0
end

 