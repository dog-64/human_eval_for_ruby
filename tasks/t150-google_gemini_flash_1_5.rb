def x_or_y(n, x, y)
  return y if n <= 1
  (2...n).each {|i| return y if n % i == 0}
  x
end
