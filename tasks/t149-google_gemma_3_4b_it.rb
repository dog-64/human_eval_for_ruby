def sorted_list_sum(lst)
  filtered_list = lst.select { |s| s.length.odd? }
  filtered_list.sort_by { |s| [s.length, s] }
end
