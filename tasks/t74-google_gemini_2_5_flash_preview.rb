def total_match(lst1, lst2)
  sum1 = lst1.sum(&:length)
  sum2 = lst2.sum(&:length)

  if sum1 <= sum2
    lst1
  else
    lst2
  end
end
