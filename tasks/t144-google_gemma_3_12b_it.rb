def simplify(x, n)
  num_x, den_x = x.split('/').map(&:to_i)
  num_n, den_n = n.split('/').map(&:to_i)
  
  numerator = num_x * num_n
  denominator = den_x * den_n
  
  numerator % denominator == 0
end
