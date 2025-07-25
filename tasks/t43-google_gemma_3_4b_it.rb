def pairs_sum_to_zero(numbers)
  return false if numbers.empty?

  seen = Set.new
  numbers.each do |num|
    if seen.include?(-num)
      return true
    end
    seen.add(num)
  end

  false
end
