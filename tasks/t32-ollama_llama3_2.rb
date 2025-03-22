def find_zero(xs)
  xs = xs.map(&:to_f).reverse
  eps = 1e-10
  x = (xs[0] + eps) / 2
  while true
    poly_x = xs[0]
    for i in 1..(xs.size/2)
      poly_x += xs[i] * (x ** (i - 1))
    end
    if poly_x < -eps
      x -= eps
    elsif poly_x > eps
      x += eps
    else
      return x
    end
  end
end