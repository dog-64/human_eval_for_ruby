def pairs_sum_to_zero?(numbers)
  return false if numbers.empty?

  seen = {}
  numbers.each do |num|
    if seen[num] || seen[-num]
      return true
    end
    seen[num] = true
  end

  false
end