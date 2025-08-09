def order_by_points(nums)
  nums.each_with_index
      .map { |num, idx| [num, num.abs.digits.sum, idx] }
      .sort_by { |_, sum, idx| [sum, idx] }
      .map { |num, _, _| num }
end