def choose_num(x, y)
  return -1 if x > y
  (x..y).select { |i| i.even? }.max || -1
end