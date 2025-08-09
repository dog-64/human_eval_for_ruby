def pairs_sum_to_zero(numbers)
  seen = {}
  numbers.each do |num|
    next if num == 0
    return true if seen.key?(-num)
    seen[num] = true
  end
  false
end