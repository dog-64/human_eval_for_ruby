def total_match(lst1, lst2)
  lst1_sum = lst1.map(&:length).sum
  lst2_sum = lst2.map(&:length).sum

  lst1_sum < lst2_sum ? lst1 : lst2
end