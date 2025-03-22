
def derivative(coefficients)
    return [] if coefficients.empty?
    return [] if coefficients.size == 1
    coefficients[1..-1].each_with_index.map { |coeff, i| coeff * (i + 1) }
end