def derivative(coefficients)
  return [] if coefficients.empty?
  return [] if coefficients.size == 1
  
  derivative_coefficients = []
  (coefficients.size - 1).times do |i|
    derivative_coefficients[i] = coefficients[i + 1] * (i + 1)
  end
  
  return derivative_coefficients
end