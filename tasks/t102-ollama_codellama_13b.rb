def choose_num(x, y)
  return -1 if x > y || x < 0 || y < 0

  nums = (x..y).select { |n| n % 2 == 0 }
  nums.max || -1
end
puts choose_num(12, 15) # Output: 14
puts choose_num(13, 15) # Output: 14
puts choose_num(13, 12) # Output: -1
puts choose_num(1, 3) # Output: 2
puts choose_num(1, 1) # Output: -1 (if x = y and not even)
puts choose_num(2, 2) # Output: 2 (if x = y and even)
puts choose_num(100, 101) # Output: 100