def sum_digits(n)
  n.abs.to_s.chars.map(&:to_i).sum
end

def order_by_points(nums)
  nums.each_with_index.sort_by { |num, index| [sum_digits(num), index] }.map(&:first)
end