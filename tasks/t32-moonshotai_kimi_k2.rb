def find_zero(xs)
  n = xs.length - 1
  return -xs[0].to_f / xs[1] if n == 1
  
  def poly(coeffs, x)
    coeffs.each_with_index.reduce(0.0) { |sum, (c, i)| sum + c * (x ** i) }
  end
  
  def derivative(coeffs)
    coeffs.each_with_index.map { |c, i| c * i }[1..-1]
  end
  
  deriv = derivative(xs)
  
  x = 0.0
  100.times do
    fx = poly(xs, x)
    dfx = poly(deriv, x)
    break if dfx.abs < 1e-10
    x = x - fx / dfx
  end
  
  x
end