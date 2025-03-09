puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1, 2, 3, 5, 4, 7, 9, 6]) == 4
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1, 2, 3, 4, 3, 2, 2]) == 1
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1, 2, 3, 2, 1]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1,1,1,1,1]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1,2,3,4,5]) == 2
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1,2,2,1]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1, 2, 3, 4, 5, 6]) == 3
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1,1,2,2,3,3]) == 2
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1,2,3,3,2,1]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
assert smallest_change([1,2,1,2,1]) == 0
puts "#{__FILE__}:#{__LINE__} [DEBUG] | "
