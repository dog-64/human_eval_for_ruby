def total_match(lst1, lst2)
  total_length1 = lst1.sum(&:length)
  total_length2 = lst2.sum(&:length)
  total_length1 <= total_length2 ? lst1 : lst2
end