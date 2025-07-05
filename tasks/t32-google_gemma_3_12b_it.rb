def find_zero(xs)
  x = -100.0
  tolerance = 1e-6
  max_iterations = 100

  (1..max_iterations).each do
    fx = xs.reduce(0.0) { |acc, coeff| acc + coeff * (x ** xs.index(coeff)) }
    f_prime_x = 0.0
    (1...xs.length).each do |i|
      f_prime_x += i * xs[i] * (x ** (i - 1))
    end

    if f_prime_x == 0.0
      x -= fx / 1e-9 # Avoid division by zero
    else
      x -= fx / f_prime_x
    end

    if fx.abs < tolerance
      return x
    end
  end

  x
end
