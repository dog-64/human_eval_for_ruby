def triples_sum_to_zero(numbers)
  return false if numbers.length < 3
  numbers.permutation(3).any? { |a, b, c| a + b + c == 0 && a != b && a != c && b != c }
end
