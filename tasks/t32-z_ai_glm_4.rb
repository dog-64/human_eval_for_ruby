
def find_zero(xs)
  x = 0.0
  max_iter = 100
  tolerance = 1e-10

  max_iter.times do
    fx = poly(x, xs)
    return x if fx.abs < tolerance

    fpx = poly_prime(x, xs)
    if fpx.abs < tolerance
      x += 1.0
      next
    end

    x_next = x - fx / fpx
    return x_next if (x_next - x).abs < tolerance
    x = x_next
  end

  x
end

def poly(x, xs)
  b = 0.0
  xs.reverse_each do |coef|
    b = b * x + coef
  end
  b
end

def poly_prime(x, xs)
  return 0.0 if xs.length <= 1
  n = xs.length - 1
  b = 0.0
  n.downto(1) do |i|
    b = b * x + i * xs[i]
  end
  b
end