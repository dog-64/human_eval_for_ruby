def pairs_sum_to_zero(numbers)
  return false if numbers.empty?

  numbers.combination(2).any? do |a, b|
    a + b == 0
  end
end