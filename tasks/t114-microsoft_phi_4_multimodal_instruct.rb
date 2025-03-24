def min_sub_array_sum(nums)
  min_ending_here = nums[0]
  min_so_far = nums[0]
  nums.each_with_index do |num, index|
    min_ending_here = [num, min_ending_here + num].min
    min_so_far = [min_so_far, min_ending_here].min
    return min_so_far if min_ending_here < 0
  end
  min_so_far
end