def next_smallest(list)
  unique_sorted_list = list.uniq.sort
  unique_sorted_list.length >= 2 ? unique_sorted_list[1] : nil
end