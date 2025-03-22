def order_by_points(nums)
  nums.sort_by { |num| [sum_of_digits(num), nums.index(num)] }
end

def sum_of_digits(num)
  num.abs.digits.sum
end