def derivative(coefficients)
  return [] if coefficients.empty?
  return [] if coefficients.length == 1
  
  derivative_coefficients = []
  (1...coefficients.length).each do |i|
    derivative_coefficients << coefficients[i] * i
  end
  
  derivative_coefficients
end