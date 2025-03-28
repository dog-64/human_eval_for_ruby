def sort_array(array)
  sorted_array = array.dup
  sum = array.first + array.last
  return sorted_array if sum.even?

  sorted_array.sort!
  sorted_array.reverse!
end