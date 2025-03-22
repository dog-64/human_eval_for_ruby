def find_zero(xs)
  n = xs.size - 1
  a = xs.last
  b = xs[-2]
  
  x = -b / (a * n)
  
  epsilon = 1e-10
  max_iterations = 1000
  
  max_iterations.times do
    poly = xs.each_with_index.sum { |coeff, i| coeff * x**i }
    derivative = xs.each_with_index.sum { |coeff, i| i * coeff * x**(i-1) } if i > 0
    
    break if poly.abs < epsilon
    
    x -= poly / derivative
  end
  
  x
end