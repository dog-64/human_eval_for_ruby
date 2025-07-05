def sort_even_elements(list)
  even_indexed_elements = []
  list.each_with_index do |item, index|
    even_indexed_elements << item if index.even?
  end

  sorted_even_indexed_elements = even_indexed_elements.sort

  result = []
  even_sorted_index = 0
  list.each_with_index do |item, index|
    if index.even?
      result << sorted_even_indexed_elements[even_sorted_index]
      even_sorted_index += 1
    else
      result << item
    end
  end
  result
end