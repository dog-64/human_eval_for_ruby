def sort_even_elements(list)
  even_elements = list.select.with_index { |_, i| i.even? }.sort
  list.map.with_index { |_, i| i.even? ? even_elements.shift : _ }
end