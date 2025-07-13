def choose_num(x, y)
  return -1 if x > y
  
  y.even? ? y : (y - 1 >= x ? y - 1 : -1)
end