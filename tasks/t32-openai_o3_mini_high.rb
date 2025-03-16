def find_zero(xs)
  raise ArgumentError, "List must have an even number of coefficients" if xs.size % 2 != 0
  raise ArgumentError, "Leading coefficient cannot be zero" if xs.last == 0

  # Define the polynomial f(x) = xs[0] + xs[1]*x + xs[2]*x^2 + ...
  f = ->(x) { xs.each_with_index.inject(0.0) { |sum, (coef, i)| sum + coef * (x ** i) } }
  tol = 1e-7

  # if f(0) is approximately 0, return 0 immediately
  return 0.0 if f.call(0.0).abs < tol

  # Find an interval [left, right] where f(left) and f(right) have opposite signs.
  r = 1.0
  while f.call(-r) * f.call(r) > 0
    r *= 2
  end
  left = -r
  right = r

  # Apply the bisection method until the interval is sufficiently small.
  while (right - left) > tol
    mid = (left + right) / 2.0
    fmid = f.call(mid)
    return mid if fmid.abs < tol
    if f.call(left) * fmid < 0
      right = mid
    else
      left = mid
    end
  end
  (left + right) / 2.0
end