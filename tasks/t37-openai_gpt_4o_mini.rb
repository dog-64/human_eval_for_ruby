def sort_even_elements(list)
  even_elements = list.each_with_index.select { |_, index| index.even? }.map(&:first).sort
  list.each_with_index.map { |elem, index| index.even? ? even_elements.shift : elem }
end