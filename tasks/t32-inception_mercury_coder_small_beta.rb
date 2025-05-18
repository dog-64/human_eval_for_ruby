def find_zero(xs)
  def poly(x, xs)
    xs.each_with_index.reduce(0) { |sum, (coeff, idx)| sum + coeff * (x ** idx) }
  end

  def derivative(xs)
    xs.each_with_index.map { |coeff, idx| coeff * idx }.drop(1)
  end

  def newton_raphson_root_finding(f, df, x0, tol: 1e-7, max_iter: 1000)
    x = x0
    max_iter.times do
      fx = f.call(x)
      dfx = df.call(x)
      return x if dfx.abs < tol
      x -= fx / dfx
    end
    x
  end

  f = ->(x) { poly(x, xs) }
  df = ->(x) { poly(x, derivative(xs)) }

  newton_raphson_root_finding(f, df, 0.0)
end