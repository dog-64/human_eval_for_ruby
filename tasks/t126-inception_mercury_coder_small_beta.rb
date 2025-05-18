def is_sorted?(lst)
  return true if lst.empty?
  sorted_lst = lst.sort
  sorted_lst == lst && sorted_lst.uniq.size == lst.size
end