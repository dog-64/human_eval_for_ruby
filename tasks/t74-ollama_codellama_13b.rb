def total_match(lst1, lst2)
  sum1 = lst1.inject(0) { |sum, word| sum + word.length }
  sum2 = lst2.inject(0) { |sum, word| sum + word.length }
  return lst1 if sum1 < sum2
  return lst2 if sum2 < sum1
  nil
end