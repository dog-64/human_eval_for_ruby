def triples_sum_to_zero(numbers)
  return false if numbers.size < 3

  numbers.combination(3).any? { |a, b, c| a + b + c == 0 }
end