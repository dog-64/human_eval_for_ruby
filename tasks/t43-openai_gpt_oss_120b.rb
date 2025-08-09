def pairs_sum_to_zero(numbers)
  seen = {}
  numbers.each do |n|
    next if n == 0
    return true if seen[-n]
    seen[n] = true
  end
  false
end