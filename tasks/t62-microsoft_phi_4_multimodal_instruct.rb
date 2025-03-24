def derivative(coefficients)
  return [] if coefficients.size <= 1
  coefficients[1..-1].map { |c| c * coefficients.size - 1 }
end
