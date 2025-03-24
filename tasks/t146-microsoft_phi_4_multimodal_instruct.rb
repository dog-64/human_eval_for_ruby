def special_filter(nums)
  nums.count do |num|
    num > 10 && num.abs.digits.first.odd? && num.abs.digits.last.odd?
  end
end