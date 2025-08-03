
def derivative(coefficients)
  coefficients[1..-1].map.with_index(1) { |coef, i| coef * i }
end