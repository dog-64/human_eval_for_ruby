def find_zero(xs)
  poly = ->(x) { xs.each_with_index.inject(0) { |sum, (coef, i)| sum + coef * (x ** i) } }
  derivative = ->(x) { xs.each_with_index.inject(0) { |sum, (coef, i)| sum + (i * coef) * (x ** (i - 1)) if i > 0 } }
  
  x0 = 0.0
  tolerance = 1e-7
  max_iterations = 1000

  max_iterations.times do
    f_x0 = poly.call(x0)
    f_prime_x0 = derivative.call(x0)

    return x0 if f_x0.abs < tolerance

    x0 -= f_x0 / f_prime_x0
  end

  nil
end