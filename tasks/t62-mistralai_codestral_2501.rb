def derivative(coefficients)
  coefficients[1..].each_with_index.map { |coef, index| coef * (index + 1) }
end