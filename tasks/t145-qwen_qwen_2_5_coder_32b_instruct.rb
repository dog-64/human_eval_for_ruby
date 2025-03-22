def order_by_points(nums)
  nums.sort_by { |num| [num.digits.sum, nums.index(num)] }
end