
def special_filter(nums)
  count = 0
  nums.each do |num|
    next unless num > 10

    abs_num = num.abs
    last_digit = abs_num % 10
    first_digit = abs_num.to_s.chars.first.to_i

    count += 1 if first_digit.odd? && last_digit.odd?
  end
  count
end

 