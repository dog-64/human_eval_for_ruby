def sort_array(array)
  return array if array.empty?

  sum = array.first + array.last
  sorted_array = array.dup

  if sum.odd?
    sorted_array.sort
  else
    sorted_array.sort.reverse
  end
end