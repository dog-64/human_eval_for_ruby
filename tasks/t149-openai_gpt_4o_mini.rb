def sorted_list_sum(lst)
  lst.select { |str| str.length.even? }.sort_by { |str| [str.length, str] }
end