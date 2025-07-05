def special_filter(nums)
  count = 0
  nums.each do |num|
    next if num <= 10
    num_str = num.to_s
    first_digit_odd = num_str[0].to_i.odd?
    last_digit_odd = num_str[-1].to_i.odd?
    count += 1 if first_digit_odd && last_digit_odd
  end
  count
end
