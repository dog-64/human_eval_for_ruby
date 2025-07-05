def find_zero(xs)
  epsilon = 1e-6
  max_iterations = 1000

  poly = lambda do |x_val|
    result = 0.0
    xs.each_with_index do |coeff, i|
      result += coeff * (x_val ** i)
    end
    result
  end

  deriv_poly = lambda do |x_val|
    result = 0.0
    xs.each_with_index do |coeff, i|
      if i > 0
        result += coeff * i * (x_val ** (i - 1))
      end
    end
    result
  end

  x = 0.0
  max_iterations.times do
    fx = poly.call(x)
    dfx = deriv_poly.call(x)

    if dfx.abs < epsilon
      x += 0.1
      next
    end

    x_new = x - fx / dfx

    if (x_new - x).abs < epsilon
      return x_new
    end
    x = x_new
  end
  x
end