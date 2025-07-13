def pairs_sum_to_zero(numbers)
  seen = {}
  numbers.each do |num|
    return true if seen.key?(-num)
    seen[num] = true
  end
  false
end