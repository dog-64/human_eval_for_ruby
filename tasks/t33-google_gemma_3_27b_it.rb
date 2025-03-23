def sort_third(l)
  third_elements = l.select.with_index { |_, i| i % 3 == 0 }
  sorted_third_elements = third_elements.sort
  
  result = []
  sorted_index = 0
  
  l.each.with_index do |element, index|
    if index % 3 == 0
      result << sorted_third_elements[sorted_index]
      sorted_index += 1
    else
      result << element
    end
  end
  
  return result
end