def order_by_points(nums)
  nums.map.with_index { |num, index| [num, index, num.abs.digits.sum] }
      .sort_by { |num, index, digit_sum| [digit_sum, index] }
      .map { |num, index, digit_sum| num }
end