def simplify(x, n)
  x_numerator, x_denominator = x.split('/').map(&:to_i)
  n_numerator, n_denominator = n.split('/').map(&:to_i)
  product_numerator = x_numerator * n_numerator
  product_denominator = x_denominator * n_denominator
  product_numerator % product_denominator == 0
end