def total_match(lst1, lst2)
  return lst1 if lst1.sum < lst2.sum
  return lst2 if lst2.sum < lst1.sum
  lst1
end