def sorted_list_sum(lst)
  filtered_lst = lst.select { |s| s.length.even? }
  filtered_lst.sort_by { |s| [s.length, s] }
end