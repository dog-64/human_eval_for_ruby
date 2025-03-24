def common(l1, l2)
  l1 &.uniq & l2 &.uniq & Set.new &.to_a.sort
end