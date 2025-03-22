def derivative(coefficients)
    coefficients.each_with_index.map { |coeff, index| coeff * index }.drop(1)
end