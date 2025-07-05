def sorted_list_sum(lst)
  even_length_strings = lst.select { |s| s.length.even? }
  sorted_strings = even_length_strings.sort_by { |s| [s.length, s] }
  sorted_strings
end
