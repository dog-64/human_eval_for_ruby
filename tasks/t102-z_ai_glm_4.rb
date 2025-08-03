
def choose_num(x, y)
  return -1 if x > y
  candidate = y - (y % 2)
  candidate >= x ? candidate : -1
end