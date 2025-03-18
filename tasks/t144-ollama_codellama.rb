def simplify(x, n)
  x_numerator = x.split('/')[0].to_i
  x_denominator = x.split('/')[1].to_i
  n_numerator = n.split('/')[0].to_i
  n_denominator = n.split('/')[1].to_i

  result = x_numerator * n_numerator
  return true if result % x_denominator == 0 && result % n_denominator == 0

  false
end