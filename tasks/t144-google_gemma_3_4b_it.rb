def simplify(x, n)
  numerator_x = x.split('/').map(&:to_i)
  denominator_x = numerator_x[1]
  numerator_n = n.split('/').map(&:to_i)
  denominator_n = numerator_n[1]

  result_numerator = numerator_x[0] * numerator_n[0]
  result_denominator = denominator_x * denominator_n

  result_numerator % result_denominator == 0
end
