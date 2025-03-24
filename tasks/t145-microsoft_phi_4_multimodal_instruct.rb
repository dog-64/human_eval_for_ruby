def order_by_points(nums)
  nums.map.with_index.sort_by { |num, index| [sum_of_digits(num), index] }
end

def sum_of_digits(num)
  num.abs.to_s.chars.map(&:ord).reduce(:+)
end