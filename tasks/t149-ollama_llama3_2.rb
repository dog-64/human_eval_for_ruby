def sorted_list_sum(lst)
  lst.delete_if { |s| s.size.odd? }
  lst.sort_by { |s| [s.size, s] }
end