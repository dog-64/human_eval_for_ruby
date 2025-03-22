def special_filter(nums)
  count = 0
  nums.each do |num|
    next if num <= 10
    s_num = num.to_s
    first_digit = s_num[0].to_i
    last_digit = s_num[-1].to_i
    if first_digit.odd? && last_digit.odd?
      count += 1
    end
  end
  count
end
