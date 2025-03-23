def sorted_list_sum(lst)
  even_length_strings = lst.filter { |str| str.length.even? }
  even_length_strings.sort_by { |str| [str.length, str] }
end