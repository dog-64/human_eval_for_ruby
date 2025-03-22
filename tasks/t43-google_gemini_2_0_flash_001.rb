def pairs_sum_to_zero(numbers)
  return false if numbers.nil? || numbers.empty?

  seen = Set.new
  numbers.each do |number|
    if seen.include?(-number)
      return true
    end
    seen.add(number)
  end

  false
end