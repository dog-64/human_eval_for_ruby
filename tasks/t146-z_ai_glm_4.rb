
def special_filter(nums)
  count = 0
  odd_digits = '13579'
  
  nums.each do |num|
    next unless num > 10
    
    s = num.to_s
    if odd_digits.include?(s[0]) && odd_digits.include?(s[-1])
      count += 1
    end
  end
  
  count
end