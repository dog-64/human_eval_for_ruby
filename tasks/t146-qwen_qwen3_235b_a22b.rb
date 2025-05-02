def special_filter(nums)
  nums.count do |n|
    next if n <= 10
    str = n.abs.to_s
    first = str[0].to_i
    last = str[-1].to_i
    first.odd? && last.odd?
  end
end