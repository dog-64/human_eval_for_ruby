def sort_array(array)
  return array.dup if array.empty? || array.size == 1
  sum = array.first + array.last
  if sum.even?
    array.dup.sort.reverse
  else
    array.dup.sort
  end
end