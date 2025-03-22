def special_filter(nums)
  nums.count do |num|
    num > 10 && num.digits.first.odd? && num.digits.last.odd?
  end
end