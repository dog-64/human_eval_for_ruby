def choose_num(x, y)
  return -1 if x > y
  (x..y).to_a.reverse.find(&:even?) || -1
end