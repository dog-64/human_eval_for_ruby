def min_sub_array_sum(nums)
  current_min = nums[0]
  min_sum = nums[0]

  nums[1..-1].each do |num|
    current_min = [num, current_min + num].min
    min_sum = [min_sum, current_min].min
  end

  min_sum
end