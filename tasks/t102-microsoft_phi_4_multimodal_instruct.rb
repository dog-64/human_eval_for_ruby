def choose_num(x, y)
  return -1 if x > y || x < 0 || y < 0
  return x if x.even?
  y - (y % 2)
end