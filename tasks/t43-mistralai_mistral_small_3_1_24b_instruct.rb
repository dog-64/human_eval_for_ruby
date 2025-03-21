def pairs_sum_to_zero(numbers)
  seen = Set.new
  numbers.each do |num|
    return true if seen.include?(num * -1)
    seen.add(num)
  end
  false
end