def simplify(x, n)
  numer_x, denom_x = x.split('/')
  numer_n, denom_n = n.split('/')
  
  result_numer = numer_x.to_i * numer_n.to_i
  result_denom = denom_x.to_i * denom_n.to_i
  
  result_numer % result_denom == 0
end
