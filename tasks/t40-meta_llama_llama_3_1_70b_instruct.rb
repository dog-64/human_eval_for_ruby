def triples_sum_to_zero(numbers)
  numbers.combination(3).any? { |a, b, c| a + b + c == 0 }
end