def min_sub_array_sum(nums)
  min_sum = Float::INFINITY
  current_sum = 0
  
  nums.each do |num|
    current_sum += num
    min_sum = [min_sum, current_sum].min
    current_sum = [current_sum, 0].min
  end
  
  min_sum
end