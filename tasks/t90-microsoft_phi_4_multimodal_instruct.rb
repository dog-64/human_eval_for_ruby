def next_smallest(list)
  return nil if list.length < 2

  sorted_list = list.sort
  sorted_list[1]
end