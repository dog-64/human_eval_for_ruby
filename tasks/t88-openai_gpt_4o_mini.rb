def sort_array(array)
  return [] if array.empty?
  sum = array.first + array.last
  sorted_array = array.dup
  sum.odd? ? sorted_array.sort : sorted_array.sort.reverse
end