def total_match(lst1, lst2)
  lst1_total_length = lst1.join.length
  lst2_total_length = lst2.join.length
  lst1_total_length <= lst2_total_length ? lst1 : lst2
end