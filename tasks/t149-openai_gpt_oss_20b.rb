def sorted_list_sum(lst)
  filtered = lst.select { |s| s.length.even? }
  filtered.sort_by { |s| [s.length, s] }
end