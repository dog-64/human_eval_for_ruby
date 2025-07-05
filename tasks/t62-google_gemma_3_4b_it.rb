def derivative(coefficients)
  derivative_coefficients = []
  n = coefficients.length
  if n == 0
    return derivative_coefficients
  end
  if n == 1
    return derivative_coefficients
  end

  (0...n - 1).each do |i|
    derivative_coefficients << coefficients[i] * (i + 1)
  end

  derivative_coefficients
end
