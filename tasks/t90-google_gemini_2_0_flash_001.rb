def next_smallest(list)
  return nil if list.length < 2
  
  unique_elements = list.uniq.sort
  
  return nil if unique_elements.length < 2
  
  unique_elements[1]
end