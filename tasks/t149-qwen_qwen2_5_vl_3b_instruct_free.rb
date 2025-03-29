def sorted_list_sum(lst)
  lst.reject { |s| s.length.odd? }.sort_by { |s| [s.length, s] }
end