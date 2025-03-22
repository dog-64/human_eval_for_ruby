def next_smallest(list)
  return nil if list.length < 2
  sorted_list = list.uniq.sort
  return nil if sorted_list.length < 2
  sorted_list[1]
end
