def order_by_points(nums)
  nums.map.with_index { |n, i| [n.abs, i] }.sort_by(&:first).map { |_, i| nums[i] }
end