def derivative(coefficients)
  return [] if coefficients.length <= 1
  coefficients.each_with_index.map do |coefficient, index|
    coefficient * index if index > 0
  end.compact.drop(1)
end