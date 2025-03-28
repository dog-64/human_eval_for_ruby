def derivative(coefficients)
  coefficients.each_with_index.map do |coefficient, index|
    coefficient * index if index > 0
  end
end