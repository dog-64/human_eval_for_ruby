def sort_even_elements(list)
  even_elements = list.select.with_index { |_, i| i.even? }
  sorted_even_elements = even_elements.sort
  sorted_even_elements_index = 0

  list.map.with_index do |element, index|
    if index.even?
      sorted_even_elements[sorted_even_elements_index].tap { sorted_even_elements_index += 1 }
    else
      element
    end
  end
end