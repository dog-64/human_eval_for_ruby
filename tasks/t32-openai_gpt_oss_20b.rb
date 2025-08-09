def find_zero(xs)
  poly = ->(x) do
    result = 0.0
    xs.reverse_each { |coeff| result = result * x + coeff }
    result
  end

  a = -1.0
  b = 1.0
  fa = poly.call(a)
  fb = poly.call(b)

  if fa == 0.0
    return a
  elsif fb == 0.0
    return b
  end

  # Expand interval until sign change
  while fa * fb > 0
    a *= 2
    b *= 2
    fa = poly.call(a)
    fb = poly.call(b)
  end

  # Bisection
  100.times do
    mid = (a + b) / 2.0
    fm = poly.call(mid)
    return mid if fm == 0.0
    if fa * fm < 0
      b = mid
      fb = fm
    else
      a = mid
      fa = fm
    end
  end

  (a + b) / 2.0
end