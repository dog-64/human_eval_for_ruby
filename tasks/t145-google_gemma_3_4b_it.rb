def order_by_points(nums)
  nums.sort_by do |num|
    sum_of_digits(num)
  end.reverse
end

def sum_of_digits(num)
  num.abs.to_s.chars.map(&:to_i).sum
end
