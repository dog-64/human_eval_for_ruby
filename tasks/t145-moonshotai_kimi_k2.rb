def order_by_points(nums)
  nums.each_with_index.sort_by { |num, idx| [num.abs.digits.sum, idx] }.map(&:first)
end