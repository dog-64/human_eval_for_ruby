puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1, 2, 1], 5) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1, 2], 5) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([3, 2, 3], 1) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([3, 2, 3], 9) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([3], 5) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([], 5) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1, -1, 1], 1) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1, -1, 1], 0) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1, 2, 3, 4, 5], 15) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([5, 4, 3, 2, 5], 20) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([-1, 0, 1], 0) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([-1, 0, 1], -1) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 10) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 9) == true
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 8) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 7) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 6) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 5) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 4) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 3) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 2) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 1) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], 0) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert will_it_fly?([1,2,3,2,1], -1) == false
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
