def triples_sum_to_zero(numbers)
  return false if numbers.length < 3

  numbers.combination(3).any? do |a, b, c|
    a + b + c == 0
  end
end