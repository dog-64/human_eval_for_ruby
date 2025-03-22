def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = []
  min_value = lst.min
  max_value = lst.max

  while min_value <= max_value
    sorted_list << min_value
    sorted_list << max_value

    lst.delete(min_value)
    lst.delete(max_value)

    min_value = lst.min
    max_value = lst.max
  end

  return sorted_list
end