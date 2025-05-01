def pairs_sum_to_zero?(numbers)
  return false if numbers.empty?

  seen = {}
  numbers.each do |num|
    complement = -num
    if seen.key?(complement) && seen[complement] != num
      return true
    end
    seen[num] = num
  end
  false
end