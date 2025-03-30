
def triples_sum_to_zero(numbers)
  numbers.combinations(3).any? { |a, b, c| [a, b, c].uniq.size == 3 && a + b + c == 0 }
end

 