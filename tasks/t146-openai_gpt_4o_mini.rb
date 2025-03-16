def special_filter(nums)
  nums.count do |num|
    num > 10 && num.to_s[0].to_i.odd? && num.to_s[-1].to_i.odd?
  end
end