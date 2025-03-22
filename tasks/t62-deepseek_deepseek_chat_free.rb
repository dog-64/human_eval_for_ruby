def derivative(coefficients)
  coefficients.each_with_index.map { |coef, index| coef * index }[1..-1] || []
end