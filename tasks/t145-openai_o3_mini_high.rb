def order_by_points(nums)
  nums.each_with_index.sort_by do |num, idx|
    [num.abs.to_s.chars.map(&:to_i).sum, idx]
  end.map(&:first)
end