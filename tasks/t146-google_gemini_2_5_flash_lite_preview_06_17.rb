def special_filter(nums)
  nums.count do |num|
    next unless num > 10

    str_num = num.abs.to_s
    first_digit_odd = str_num[0].to_i.odd?
    last_digit_odd = str_num[-1].to_i.odd?

    first_digit_odd && last_digit_odd
  end
end