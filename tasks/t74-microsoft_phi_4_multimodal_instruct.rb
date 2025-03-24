def total_match(lst1, lst2)
  sum1 = lst1.sum { |s| s.size }
  sum2 = lst2.sum { |s| s.size }
  sum1 < sum2 ? lst1 : lst2
end