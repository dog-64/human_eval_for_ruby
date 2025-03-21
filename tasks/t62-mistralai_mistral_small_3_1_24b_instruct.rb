def derivative(coefficients)
  coefficients.each_with_index.drop(1).map { |coeff, index| coeff * (index + 1) }
end