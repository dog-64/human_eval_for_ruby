def derivative(coefficients)
  return [] if coefficients.size <= 1
  coefficients[1..-1].map.with_index { |coeff, index| coeff * (index + 1) }
end