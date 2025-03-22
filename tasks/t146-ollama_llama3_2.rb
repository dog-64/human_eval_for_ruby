def special_filter(nums)
  nums.select { |x| x > 10 && (x.to_s[0] & 1) == 1 && (x.to_s[-1] & 1) == 1 }.size
end