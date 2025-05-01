def find_zero(xs)
  epsilon = 1e-6
  max_iterations = 1000
  x = 0.0

  max_iterations.times do
    poly_val = 0.0
    deriv_val = 0.0
    xs.each_with_index do |coeff, i|
      poly_val += coeff * (x ** i)
      deriv_val += coeff * i * (x ** (i - 1)) if i > 0
    end

    break if poly_val.abs < epsilon

    if deriv_val.abs < epsilon
      x += 0.1 # Сдвигаем, если производная близка к нулю
    else
      x -= poly_val / deriv_val
    end
  end
  x
end
