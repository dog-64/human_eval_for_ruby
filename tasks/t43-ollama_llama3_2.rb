def pairs_sum_to_zero(numbers)
  return false if numbers.empty?
  hash = {}
  for num in numbers
    if (hash[num] && hash[num] != -1) || hash[num] == nil
      hash[num] = -1
      break unless hash[-(num)]
    end
    hash[num] = true
  end
  return false unless hash.values.include?(true)
  true
end