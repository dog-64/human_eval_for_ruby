def next_smallest(list)
  return nil if list.empty? || list.size < 2

  sorted_list = list.sort
  second_smallest = sorted_list[1]
  second_smallest
end