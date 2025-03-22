def derivative(coefficients)
  return [] if coefficients.empty?
  result = []
  for i in 1...coefficients.size
    result << (i * coefficients[i])
  end
  result
end