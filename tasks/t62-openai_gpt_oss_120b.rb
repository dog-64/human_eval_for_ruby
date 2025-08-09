def derivative(coefficients)
  return [] if coefficients.nil? || coefficients.length <= 1
  (1...coefficients.length).map { |i| coefficients[i] * i }
end