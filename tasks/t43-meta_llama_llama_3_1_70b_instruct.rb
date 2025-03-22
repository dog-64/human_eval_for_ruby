def pairs_sum_to_zero(numbers)
  hash = {}
  numbers.any? do |num|
    hash[-num]? true : (hash[num] = true)
  end
end