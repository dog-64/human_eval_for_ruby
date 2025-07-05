def common(l1, l2)
  set1 = l1.to_set
  set2 = l2.to_set
  intersection = set1 & set2
  intersection.to_a.sort
end
