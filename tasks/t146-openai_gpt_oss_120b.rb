def special_filter(nums)
  count = 0
  nums.each do |n|
    next unless n > 10
    s = n.abs.to_s
    first_digit = s[0].ord - 48
    last_digit = s[-1].ord