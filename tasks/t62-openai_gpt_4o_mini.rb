def derivative(coefficients)
  return [] if coefficients.empty?
  coefficients.each_with_index.map { |coeff, index| coeff * index }.drop(1)
end