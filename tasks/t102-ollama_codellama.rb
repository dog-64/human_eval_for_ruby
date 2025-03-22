def choose_num(x, y)
  return -1 if x > y || x < 0 || y < 0

  nums = (x..y).select { |n| n % 2 == 0 }
  nums.max || -1
end
