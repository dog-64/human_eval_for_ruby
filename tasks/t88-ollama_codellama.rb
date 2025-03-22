
def sort_array(array)
  return array if array.empty? || array.size == 1

  sum = array.first + array.last
  if sum.odd?
    array.sort
  else
    array.sort.reverse
  end
end