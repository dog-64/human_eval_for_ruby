def choose_num(x, y)
  return -1 if x > y
  return x if x % 2 == 0
  return y if y % 2 == 0
  return -1
end
