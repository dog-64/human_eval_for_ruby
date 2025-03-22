def triples_sum_to_zero(numbers)
  return false if numbers.size < 3
  hash = {}
  for i in 0...numbers.size do
    for j in (i+1)...numbers.size do
      diff = numbers[j] - numbers[i]
      if hash.key?(diff) && hash[diff] != i
        return true
      end
      hash[diff] = i
    end
  end
  false
end