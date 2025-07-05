def min_sub_array_sum(nums)
  min_so_far = nums[0]
  current_min = nums[0]

  (1...nums.length).each do |i|
    current_min = [nums[i], current_min + nums[i]].min
    min_so_far = [min_so_far, current_min].min
  end

  min_so_far
end
