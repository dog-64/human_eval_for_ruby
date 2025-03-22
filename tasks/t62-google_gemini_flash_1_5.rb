def derivative(coefficients)
  return [] if coefficients.empty?
  coefficients[0...coefficients.length-1].map.with_index{|c, i| c * (i + 1)}
end
