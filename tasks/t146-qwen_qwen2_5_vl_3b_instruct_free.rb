def special_filter(nums)
  nums.count { |num| num > 10 && num.abs % 2 != 0 }
end
