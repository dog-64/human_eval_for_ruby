def order_by_points(nums)
  nums.map.with_index do |num, index|
    sum_digits = num.abs.to_s.chars.map(&:to_i).sum
    [sum_digits, index, num]
  end.sort_by do |sum_digits, index, num|
    [sum_digits, index]
  end.map do |sum_digits, index, num|
    num
  end
end