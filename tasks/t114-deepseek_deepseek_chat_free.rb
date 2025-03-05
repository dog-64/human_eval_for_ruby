def min_sub_array_sum(nums)
  min_sum = nums[0]
  current_sum = nums[0]

  (1...nums.length).each do |i|
    current_sum = [nums[i], current_sum + nums[i]].min
    min_sum = [min_sum, current_sum].min
  end

  min_sum
end