def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_lst = []
  while lst.length > 0
    min_val = lst.min
    sorted_lst << min_val
    lst.delete(min_val)

    max_val = lst.max
    sorted_lst << max_val
    lst.delete(max_val)
  end

  sorted_lst
end