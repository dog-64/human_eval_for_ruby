def sort_even_elements(list)
  even_elements = list.select.with_index { |_, i| i.even? }
  sorted_even_elements = even_elements.sort
  result = []
  sorted_index = 0
  list.each.with_index do |element, index|
    if index.even?
      result << sorted_even_elements[sorted_index]
      sorted_index += 1
    else
      result << element
    end
  end
  return result
end