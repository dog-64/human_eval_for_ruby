def simplify(x, n)
  num1, den1 = x.split('/').map(&:to_i)
  num2, den2 = n.split('/').map(&:to_i)
  result_numerator = num1 * num2
  result_denominator = den1 * den2
  result_numerator % result_denominator == 0
end