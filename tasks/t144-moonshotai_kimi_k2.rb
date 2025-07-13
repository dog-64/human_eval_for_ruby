def simplify(x, n)
  x_num, x_den = x.split('/').map(&:to_i)
  n_num, n_den = n.split('/').map(&:to_i)
  
  result_num = x_num * n_num
  result_den = x_den * n_den
  
  result_num % result_den == 0
end