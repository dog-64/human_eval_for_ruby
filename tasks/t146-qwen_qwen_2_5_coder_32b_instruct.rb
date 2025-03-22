def special_filter(nums)
  nums.count { |num| num.abs > 10 && num.to_s.match(/\A[13579].*[13579]\z/) }
end