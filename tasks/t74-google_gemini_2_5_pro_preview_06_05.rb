def total_match(lst1, lst2)
  len1 = lst1.sum(&:length)
  len2 = lst2.sum(&:length)

  if len1 <= len2
    lst1
  else
    lst2
  end
end
