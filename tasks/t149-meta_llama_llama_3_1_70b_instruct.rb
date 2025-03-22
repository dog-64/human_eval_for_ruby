def sorted_list_sum(lst)
  lst.select { |s| s.size.even? }.sort_by { |s| [s.size, s] }
end