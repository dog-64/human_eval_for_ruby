def total_match(lst1, lst2)
  sum1 = lst1.reduce(0) { |acc, s| acc + s.length }
  sum2 = lst2.reduce(0) { |acc, s| acc + s.length }
  sum1 <= sum2 ? lst1 : lst2
end