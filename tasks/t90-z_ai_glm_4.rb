def next_smallest(list)
  unique_sorted = list.uniq.sort
  unique_sorted.size < 2 ? nil : unique_sorted[1]
end