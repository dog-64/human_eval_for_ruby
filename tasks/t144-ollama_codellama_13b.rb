def simplify(x, n)
  x_numerator, x_denominator = x.split('/')
  n_numerator, n_denominator = n.split('/')
  result = x_numerator.to_i * n_numerator.to_i
  return true if result % n_denominator.to_i == 0
  false
end