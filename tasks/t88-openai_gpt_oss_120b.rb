def sort_array(array)
  return [] if array.empty?
  sum = array.first + array.last
  sorted = array.sort
  sum.odd? ? sorted : sorted.reverse
end