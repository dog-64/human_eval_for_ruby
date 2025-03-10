def find_zero(xs)
  def poly(x, coeffs)
    result = 0.0
    coeffs.each_with_index do |coeff, index|
      result += coeff * (x ** index)
    end
    result
  end

  # Используем метод Ньютона
  x = 0.0
  epsilon = 1e-6
  max_iterations = 100

  (0..max_iterations).each do |_|
    fx = poly(x, xs)
    f_prime_x = 0.0
    (1...xs.length).each do |index|
      f_prime_x += index * xs[index] * (x ** (index - 1))
    end

    if f_prime_x.abs < epsilon
      break
    end

    delta_x = fx / f_prime_x
    x -= delta_x

    if delta_x.abs < epsilon
      break
    end
  end

  x
end