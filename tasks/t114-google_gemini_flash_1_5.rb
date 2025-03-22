def min_sub_array_sum(nums)
  min_so_far = Float::INFINITY
  current_min = 0
  nums.each do |num|
    current_min += num
    min_so_far = [min_so_far, current_min].min
    current_min = [0, current_min].max
  end
  min_so_far
end
