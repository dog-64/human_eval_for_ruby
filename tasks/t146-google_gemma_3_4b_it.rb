def special_filter(nums)
  count = 0
  nums.each do |num|
    if num > 10 && (num.to_s.last == '1' || num.to_s.last == '3' || num.to_s.last == '5' || num.to_s.last == '7' || num.to_s.last == '9')
      count += 1
    end
  end
  count
end
