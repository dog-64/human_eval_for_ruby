def derivative(coefficients)
  return [] if coefficients.length <= 1

  derivative_coefficients = []
  coefficients.each_with_index do |coeff, index|
    next if index == 0
    derivative_coefficients << coeff * index
  end
  derivative_coefficients
end
