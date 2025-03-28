def simplify(x, n)
  num1, denom1 = x.split('/')
  num2, denom2 = n.split('/')
  
  result_num = num1.to_i * num2.to_i
  result_denom = denom1.to_i * denom2.to_i
  
  result_num % result_denom == 0
end