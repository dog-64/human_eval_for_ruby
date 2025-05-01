def sort_array(array)
  return [] if array.empty?
  return array.dup if array.length == 1

  first_element = array.first
  last_element = array.last
  sum = first_element + last_element

  sorted_array = array.dup

  if sum.odd?
    sorted_array.sort
  else
    sorted_array.sort.reverse
  end
end