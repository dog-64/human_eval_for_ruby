def special_filter(nums)
  nums.count { |n| n > 10 && n.to_s[0].to_i.odd? && n.to_s[-1].to_i.odd? }
end