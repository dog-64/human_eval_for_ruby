def min_sub_array_sum(nums)
  current_min = nums[0]
  min_sum = nums[0]
  nums[1..-1].each do |x|
    current_min = [current_min + x, x].min
    min_sum = [min_sum, current_min].min
  end
  min_sum
end