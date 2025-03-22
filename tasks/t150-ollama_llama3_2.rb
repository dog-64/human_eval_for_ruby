def x_or_y(n, x, y)
  return x if n == 1 || n == 0
  return y unless n.even?
  x_or_y(n / 2, x, y)
end