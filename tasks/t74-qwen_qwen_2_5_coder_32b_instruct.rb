def total_match(lst1, lst2)
  len1 = lst1.sum(&:length)
  len2 = lst2.sum(&:length)
  len1 <= len2 ? lst1 : lst2
end