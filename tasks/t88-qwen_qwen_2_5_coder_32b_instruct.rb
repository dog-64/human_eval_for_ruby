def sort_array(array)
  return array.dup.sort if array.empty? || array.size == 1
  sum = array.first + array.last
  sum.odd? ? array.dup.sort : array.dup.sort.reverse
end