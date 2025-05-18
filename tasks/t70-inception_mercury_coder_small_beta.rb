def strange_sort_list(lst)
  sorted_list = []
  while lst.any?
    min_value = lst.min
    sorted_list << min_value
    lst.delete(min_value)
    break unless lst.any?

    max_value = lst.max
    sorted_list << max_value
    lst.delete(max_value)
  end
  sorted_list
end