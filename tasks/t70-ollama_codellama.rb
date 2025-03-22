def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = []
  min_value = lst.min
  max_value = lst.max

  while min_value || max_value
    sorted_list << (min_value || max_value)
    lst.delete(min_value || max_value)
    min_value = lst.min if min_value
    max_value = lst.max if max_value
  end

  return sorted_list
end