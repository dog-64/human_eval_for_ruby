def next_smallest(list)
  return nil if list.size < 2
  uniq_sorted = list.uniq.sort
  uniq_sorted.size >= 2 ? uniq_sorted[1] : nil
end