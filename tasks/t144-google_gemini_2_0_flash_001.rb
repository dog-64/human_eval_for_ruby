def simplify(x, n)
  x_num, x_den = x.split('/').map(&:to_i)
  n_num, n_den = n.split('/').map(&:to_i)

  result = (x_num * n_num).to_f / (x_den * n_den)

  result == result.to_i
end