def x_or_y(n, x, y)
  return y if n < 2
  return x if n == 2
  return y if n.even?
  
  (3..Math.sqrt(n)).step(2) do |i|
    return y if n % i == 0
  end
  
  x
end