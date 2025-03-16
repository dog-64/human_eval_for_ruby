def next_smallest(list)
  unique_sorted = list.uniq.sort
  return nil if unique_sorted.size < 2
  unique_sorted[1]
end