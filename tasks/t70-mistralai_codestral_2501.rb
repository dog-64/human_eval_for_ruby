def strange_sort_list(lst)
  sorted_lst = []
  lst_copy = lst.dup
  while !lst_copy.empty?
    min_val = lst_copy.min
    max_val = lst_copy.max
    sorted_lst << min_val
    lst_copy.delete(min_val)
    break if lst_copy.empty?
    sorted_lst << max_val
    lst_copy.delete(max_val)
  end
  sorted_lst
end