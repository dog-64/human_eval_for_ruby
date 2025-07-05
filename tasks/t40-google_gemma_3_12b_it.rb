def triples_sum_to_zero(numbers)
  numbers.length < 3 ? false : numbers.combination(3).any? { |a, b, c| a + b + c == 0 }
end
