def special_filter(nums)
  nums.count do |num|
    next false if num <= 10
    
    digits = num.abs.to_s.chars.map(&:to_i)
    first_digit = digits.first
    last_digit = digits.last
    
    first_digit.odd? && last_digit.odd?
  end
end