def pairs_sum_to_zero(numbers)
  return false if numbers.length < 2

  seen = {}
  numbers.each_with_index do |num, index|
    complement = -num
    if seen.key?(complement) && seen[complement] != index
      return true
    end
    seen[num] = index
  end

  false
end