def order_by_points(nums)
  nums.each_with_index.sort_by do |num, index|
    sum_of_digits = num.abs.to_s.chars.map(&:to_i).sum
    [sum_of_digits, index]
  end.map(&:first)
end