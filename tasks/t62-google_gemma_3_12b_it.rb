def derivative(coefficients)
  return [] if coefficients.empty?
  return [] if coefficients.length == 1
  
  result = []
  (1...coefficients.length).each do |i|
    result << coefficients[i] * i
  end
  result
end
