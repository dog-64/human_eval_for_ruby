def next_smallest(list)
  sorted_list = list.uniq.sort
  return nil if sorted_list.size < 2
  sorted_list[1]
end