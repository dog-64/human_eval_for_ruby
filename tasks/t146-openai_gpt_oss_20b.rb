def special_filter(nums)
  count = 0
  nums.each do |n|
    next unless n > 10
    abs_str = n.abs.to_s
    first_digit = abs_str[0].to_i
    last_digit = abs_str[-1].to_i
    count += 1 if first_digit.odd? && last_digit.odd?
  end
  count
end