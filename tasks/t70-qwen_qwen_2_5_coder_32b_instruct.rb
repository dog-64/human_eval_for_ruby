def strange_sort_list(lst)
  result = []
  while lst.any?
    result << lst.delete_at(lst.index(lst.min))
    result << lst.delete_at(lst.index(lst.max)) if lst.any?
  end
  result
end