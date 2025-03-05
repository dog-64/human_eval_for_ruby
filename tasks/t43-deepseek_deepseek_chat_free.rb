def pairs_sum_to_zero(numbers)
  return false if numbers.length < 2
  seen = Set.new
  numbers.each do |num|
    if seen.include?(-num)
      return true
    else
      seen.add(num)
    end
  end
  false
end