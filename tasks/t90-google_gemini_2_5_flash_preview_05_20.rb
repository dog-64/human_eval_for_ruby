def next_smallest(list)
  unique_sorted_list = list.uniq.sort
  if unique_sorted_list.length < 2
    nil
  else
    unique_sorted_list[1]
  end
end