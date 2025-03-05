def derivative(coefficients)
  result = []
  coefficients.each_with_index do |coeff, index|
    if index > 0
      result << coeff * index
    end
  end
  result
end