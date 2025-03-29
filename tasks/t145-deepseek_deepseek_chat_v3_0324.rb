def order_by_points(nums)
  nums.each_with_index.sort_by { |num, index| [num.abs.digits.sum, index] }.map(&:first)
end