def derivative(coefficients)
  coefficients.each_with_index.map { |coeff, index| coeff * index }[1..]
end