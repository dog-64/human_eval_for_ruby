
def common(l1, l2)
  set1 = Set.new(l1)
  set2 = Set.new(l2)
  intersection = set1 & set2
  intersection.to_a.sort
end

 