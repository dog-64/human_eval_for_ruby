def choose_num(x, y)
  return -1 if y < x
  candidate = y.even? ? y : y - 1
  candidate >= x ? candidate : -1
end