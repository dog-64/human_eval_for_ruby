def next_smallest(list)
  return nil if list.length < 2

  unique_list = list.uniq
  return nil if unique_list.length < 2

  unique_list.sort[1]
end