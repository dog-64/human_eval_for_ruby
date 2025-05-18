def sort_even_elements(list)
  even_elements = list.values_at(*list.each_index.select(&:even?))
  sorted_even_elements = even_elements.sort
  result = []
  even_index = 0
  list.each_with_index do |element, index|
    if index.even?
      result << sorted_even_elements[even_index]
      even_index += 1
    else
      result << element
    end
  end
  result
end