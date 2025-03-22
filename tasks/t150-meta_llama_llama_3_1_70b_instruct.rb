def x_or_y(n, x, y)
  return y if n < 2
  2.upto(Math.sqrt(n)) { |i| return y if n % i == 0 }
  x
end