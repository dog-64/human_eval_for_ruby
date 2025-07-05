def derivative(coefficients)
  return [] if coefficients.empty? || coefficients.length == 1

  result = []
  coefficients.each_with_index do |coeff, index|
    next if index == 0
    result << coeff * index
  end
  result
end