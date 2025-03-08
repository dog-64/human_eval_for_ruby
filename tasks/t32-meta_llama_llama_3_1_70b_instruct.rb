def find_zero(xs)
  eps = 1e-6
  def poly(x, xs)
    xs.each_with_index.sum { |a, i| a * x**i }
  end
  def d_poly(x, xs)
    xs.each_with_index.sum { |a, i| a * i * x**(i-1) } if xs.size > 1
  end
  x = 0.0
  loop do
    dx = poly(x, xs) / d_poly(x, xs)
    x -= dx
    break x if dx.abs < eps
  end
end