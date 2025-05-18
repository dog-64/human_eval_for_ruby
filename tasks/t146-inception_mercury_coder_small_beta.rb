def special_filter(nums)
  nums.count do |num|
    num > 10 && num.to_s.first.odd? && num.to_s.last.odd?
  end
end