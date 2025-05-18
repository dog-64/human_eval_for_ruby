def order_by_points(nums)
  nums.each_with_index.map { |num, index| [num, index, num.to_s.chars.map(&:to_i).sum] }
         .sort_by { |_, _, sum| [sum, _1] }
         .map(&:first)
end