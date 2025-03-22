def special_filter(nums)
  nums.count do |num|
    next false if num <= 10
    num_str = num.abs.to_s
    first_digit = num_str[0].to_i
    last_digit = num_str[-1].to_i
    first_digit.odd? && last_digit.odd?
  end
end