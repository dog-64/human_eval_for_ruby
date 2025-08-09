def order_by_points(nums)
  nums.each_with_index
      .map { |num, idx| [num, idx, num.abs.to_s.chars.map { |c| c.to_i }.sum] }
      .sort_by { |_, idx, sum| [sum, idx] }
      .map { |num, _, _| num }
end