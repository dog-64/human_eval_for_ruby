def sort_third(l)
  return [] if l.empty?

  third_elements = l.select.with_index { |_, i| i % 3 == 0 }
  sorted_third_elements = third_elements.sort
  
  result = l.map.with_index do |element, i|
    if i % 3 == 0
      sorted_third_elements.shift
    else
      element
    end
  end
  
  result
end