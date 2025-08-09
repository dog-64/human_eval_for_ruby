def sort_array(array)
  arr = array.dup
  return arr if arr.empty?
  sum = arr.first + arr.last
  if sum.odd?
    arr.sort
  else
    arr.sort.reverse
  end
end