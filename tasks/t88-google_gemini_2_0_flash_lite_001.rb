def sort_array(array)
  return array.dup if array.length <= 1

  sum = array[0] + array[-1]
  sorted_array = array.dup
  if sum.odd?
    sorted_array.sort
  else
    sorted_array.sort.reverse
  end
end