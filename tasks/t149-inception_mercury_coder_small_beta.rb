def sorted_list_sum(lst)
  filtered_lst = lst.select { |str| str.length.even? }
  sorted_lst = filtered_lst.sort_by { |str| [str.length, str] }
  sorted_lst
end