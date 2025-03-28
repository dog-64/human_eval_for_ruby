def min_sub_array_sum(nums)
  min_sum = nums[0]
  current_sum = 0

  nums.each do |num|
    current_sum += num
    min_sum = current_sum if current_sum < min_sum
    current_sum = 0 if current_sum > 0
  end

  min_sum
end