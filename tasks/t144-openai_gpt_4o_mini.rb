def simplify(x, n)
  numerator1, denominator1 = x.split('/').map(&:to_i)
  numerator2, denominator2 = n.split('/').map(&:to_i)
  
  result_numerator = numerator1 * numerator2
  result_denominator = denominator1 * denominator2
  
  result_numerator % result_denominator == 0
end