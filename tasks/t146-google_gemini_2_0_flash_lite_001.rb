def special_filter(nums)
  count = 0
  nums.each do |num|
    next if num <= 10

    num_str = num.abs.to_s
    next if num_str.length < 2
    
    first_digit = num_str[0].to_i
    last_digit = num_str[-1].to_i
    
    if first_digit.odd? && last_digit.odd?
      count += 1
    end
  end
  count
end