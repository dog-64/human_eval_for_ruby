def special_filter(nums)
  nums.count { |num|
    next false if num <= 10
    digits = num.abs.to_s.chars
    first = digits.first.to_i
    last = digits.last.to_i
    first.odd? && last.odd?
  }
end
