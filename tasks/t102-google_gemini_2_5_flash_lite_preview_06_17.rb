def choose_num(x, y)
  return -1 if x > y
  (y.even? ? y : y - 1).downto(x).find(&:even?) || -1
end