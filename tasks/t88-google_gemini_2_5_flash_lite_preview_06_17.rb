def sort_array(array)
  return [] if array.empty?
  sum = array.first + array.last
  if sum.odd?
    array.sort
  else
    array.sort.reverse
  end
end