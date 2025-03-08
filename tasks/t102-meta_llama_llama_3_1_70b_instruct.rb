def choose_num(x, y)
  x, y = y, x if x > y
  (x..y).select(&:even?).max || -1
end