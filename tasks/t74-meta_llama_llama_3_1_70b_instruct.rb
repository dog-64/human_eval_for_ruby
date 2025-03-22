def total_match(lst1, lst2)
  lst1.sum(&:length) <= lst2.sum(&:length) ? lst1 : lst2
end