def sorted_list_sum(lst)
  lst.select { |s| s.length.even? }.sort
end