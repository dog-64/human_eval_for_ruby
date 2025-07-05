def next_smallest(list)
  return nil if list.length < 2

  unique_list = list.sort.uniq
  return nil if unique_list.length < 2

  unique_list[1]
end
