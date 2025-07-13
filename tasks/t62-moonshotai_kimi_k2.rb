def derivative(coefficients)
  return [] if coefficients.empty? || coefficients.size == 1
  
  coefficients.each_with_index.map { |coeff, index| coeff * index }[1..-1]
end