def common(l1, l2)
  intersection = (l1 & l2).uniq
  intersection.sort
end
