def min_sub_array_sum(nums)
  min_ending_here = nums[0]
  min_so_far = nums[0]
  
  nums[1..-1].each do |num|
    min_ending_here = [num, min_ending_here + num].min
    min_so_far = [min_so_far, min_ending_here].min
  end
  
  min_so_far
end