def derivative(coefficients)
  coefficients.each_with_index.drop(1).map { |c, i| c * i }
end