def special_filter(nums)
  count = 0
  nums.each do |num|
    if num > 10 && (num % 2 != 0 || num % 10 != 0)
      count += 1
    end
  end
  return count
end