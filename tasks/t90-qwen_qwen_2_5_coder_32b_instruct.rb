def next_smallest(list)
  return nil if list.length < 2

  unique_sorted_list = list.uniq.sort
  unique_sorted_list.length > 1 ? unique_sorted_list[1] : nil
end