def choose_num(x, y)
  return -1 if x > y
  candidate = y.even? ? y : y - 1
  candidate >= x ? candidate : -1
end