def derivative(coefficients)
  return [] if coefficients.length <= 1

  coefficients[1..].map.with_index do |coeff, index|
    (index + 1) * coeff
  end
end