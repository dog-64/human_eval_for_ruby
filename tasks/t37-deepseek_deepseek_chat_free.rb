def sort_even_elements(list)
  even_indices = list.each_with_index.map { |_, i| i if i.even? }.compact
  even_values = even_indices.map { |i| list[i] }.sort
  even_indices.each_with_index { |i, j| list[i] = even_values[j] }
  list
end