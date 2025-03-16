def total_match(lst1, lst2)
  sum1 = lst1.sum(&:length)
  sum2 = lst2.sum(&:length)
  sum1 < sum2 ? lst1 : lst2
end