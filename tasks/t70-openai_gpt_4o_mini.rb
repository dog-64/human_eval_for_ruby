def strange_sort_list(lst)
  return [] if lst.empty?

  sorted = []
  lst = lst.dup
  while lst.any?
    min_val = lst.min
    sorted << min_val
    lst.delete_at(lst.index(min_val))

    break if lst.empty?

    max_val = lst.max
    sorted << max_val
    lst.delete_at(lst.index(max_val))
  end

  sorted
end