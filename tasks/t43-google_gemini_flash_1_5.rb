def pairs_sum_to_zero(numbers)
  seen = {}
  numbers.each do |num|
    return true if seen[-num] && seen[-num] != num
    seen[num] = num
  end
  false
end
