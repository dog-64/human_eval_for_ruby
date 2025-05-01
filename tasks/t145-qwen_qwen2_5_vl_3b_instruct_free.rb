def order_by_points(nums)
  nums.each_with_object([]) do |num, result|
    sum = num.abs.to_s.chars.map(&:to_i).sum
    result << num if result.any? { |r| r[0] == sum } || result << num
  end
end
