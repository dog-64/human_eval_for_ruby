def order_by_points(nums)
  nums.sort_by.with_index { |num, index| [num.abs.to_s.chars.map(&:to_i).sum, index] }
end