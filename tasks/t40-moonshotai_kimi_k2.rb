def triples_sum_to_zero(numbers)
  return false if numbers.size < 3
  
  numbers.combination(3) do |triple|
    return true if triple.sum.zero?
  end
  
  false
end