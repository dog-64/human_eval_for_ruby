def min_sub_array_sum(nums)
  min_sum = nums.first
  current_sum = 0

  nums.each do |num|
    current_sum = [num, current_sum + num].min
    min_sum = [min_sum, current_sum].min
  end

  min_sum
end