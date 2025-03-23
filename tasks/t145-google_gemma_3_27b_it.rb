
def order_by_points(nums)
  return [] if nums.empty?

  nums.sort_by do |num, index|
    digit_sum = num.abs.to_s.chars.map(&:to_i).sum
    [digit_sum, index]
  end
end
