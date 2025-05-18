def next_smallest(list)
  return nil if list.size < 2
  unique_list = list.uniq
  return nil if unique_list.size < 2
  unique_list.sort[1]
end