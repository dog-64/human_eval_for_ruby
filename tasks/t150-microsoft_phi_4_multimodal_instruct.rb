def x_or_y(n, x, y)
  return x if n > 1 && (n - 1).even?
  return y
end