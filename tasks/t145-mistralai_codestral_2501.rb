def order_by_points(nums)
  nums.sort_by.with_index { |num, index| [num.abs.digits.sum, index] }
end