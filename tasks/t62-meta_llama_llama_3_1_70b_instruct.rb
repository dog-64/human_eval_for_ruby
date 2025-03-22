def derivative(coefficients)
  coefficients.each_with_index.map { |c, i| c * i }[1..]
end