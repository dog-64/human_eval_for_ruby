def special_filter(nums)
  nums.count do |num|
    next false if num.abs < 10

    s = num.abs.to_s
    first = s[0].to_i
    last = s[-1].to_i

    first.odd? && last.odd?
  end
end