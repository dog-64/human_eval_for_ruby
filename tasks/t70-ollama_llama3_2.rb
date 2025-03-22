def strange_sort_list(lst)
  return [] if lst.empty?
  min = lst.min
  max = lst.max
  result = [min]
  while min != max
    min_index = lst.index(min)
    lst.delete_at(min_index)
    result << max
    max_index = lst.index(max)
    lst.delete_at(max_index)
  end
  result + lst
end