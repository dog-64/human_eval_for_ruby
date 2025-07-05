def sort_array(array)
  return [] if array.empty?
  
  first_element = array.first
  last_element = array.last
  
  sum = first_element + last_element
  
  if sum.odd?
    array.sort
  else
    array.sort.reverse
  end
end