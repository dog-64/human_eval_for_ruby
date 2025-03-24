def sort_even_elements(list)
  even_indexed_elements = list.each_with_index.select { |value, index| index.even? }.map(&:first)
  sorted_even_indexed_elements = even_indexed_elements.sort
  list.each_with_index.map { |value, index| index.even? ? sorted_even_indexed_elements.shift : value }.compact
end