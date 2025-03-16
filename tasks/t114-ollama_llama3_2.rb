def min_sub_array_sum(nums)
  min = nums[0]
  sum = 0
  for i in 0...nums.size
    sum += nums[i]
    if sum < min
      min = sum
    end
    if sum <= 0
      break
    end
  end
  min
end