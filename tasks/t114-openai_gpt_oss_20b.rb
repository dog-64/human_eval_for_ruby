def min_sub_array_sum(nums)
  current_min = nums[0]
  best_min = nums[0]
  nums[1..-1].each do |x|
    current_min = [x, current_min + x].min
    best_min = [best_min, current_min].min
  end
  best_min
end