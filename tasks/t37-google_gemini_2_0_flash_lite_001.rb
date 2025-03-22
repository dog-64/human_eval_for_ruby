def sort_even_elements(list)
  return [] if list.empty?

  even_elements = list.select.with_index { |_, i| i.even? }.sort
  result = list.map.with_index do |element, i|
    if i.even?
      even_elements.shift
    else
      element
    end
  end
  result
end