def special_filter(nums)
  nums.count do |num|
    num > 10 && num.to_s.chars.first.to_i.odd? && num.to_s.chars.last.to_i.odd?
  end
end