def find_zero(xs)
  return -xs[0] / xs[1] if xs.length == 2

  x = 0.0
  tolerance = 1e-6
  max_iterations = 100

  (1..max_iterations).each do |i|
    poly_value = evaluate_polynomial(xs, x)
    derivative_value = evaluate_polynomial(xs, x, true)

    if derivative_value.abs < tolerance
      x += 0.1 # Small perturbation to avoid division by zero
    else
      x -= poly_value / derivative_value
    end

    return x if poly_value.abs < tolerance
  end

  x # Return the last approximation if no zero is found within max_iterations
end

def evaluate_polynomial(xs, x, derivative = false)
  result = 0.0
  n = xs.length - 1

  xs.each_with_index do |coeff, i|
    term = coeff * (x ** i)
    if derivative
      term *= i
    end
    result += term
  end

  result
end