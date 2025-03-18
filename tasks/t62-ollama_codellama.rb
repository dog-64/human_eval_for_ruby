def derivative(coefficients)
  return [] if coefficients.empty?
  return [] if coefficients.size == 1
  derivative = []
  for i in (0..coefficients.size-2) do
    derivative[i] = coefficients[i+1] * (i+1)
  end
  return derivative
end