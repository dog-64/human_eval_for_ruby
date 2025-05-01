def sort_even_elements(list)
  even_elements = list.each_with_index.select { |_, i| i.even? }.map(&:first).sort
  result = []
  even_index = 0
  list.each_with_index do |element, index|
    if index.even?
      result << even_elements[even_index]
      even_index += 1
    else
      result << element
    end
  end
  result
end