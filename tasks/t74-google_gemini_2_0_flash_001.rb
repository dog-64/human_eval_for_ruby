def total_match(lst1, lst2)
  sum1 = lst1.sum { |s| s.length }
  sum2 = lst2.sum { |s| s.length }
  if sum1 <= sum2
    return lst1
  else
    return lst2
  end
end