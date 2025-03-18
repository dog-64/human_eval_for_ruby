def next_smallest(list)
  return nil if list.size < 2
  min = list.min
  list.delete(min)
  list.delete_at(list.index(min))
  list.min
end