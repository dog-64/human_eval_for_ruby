def next_smallest(list)
  return nil if list.size < 2
  unique = list.uniq
  return nil if unique.size < 2
  sorted = unique.sort
  sorted[1]
end