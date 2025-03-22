def sort_array(array)
  return [] if array.empty?
  sum = array.first + array.last
  sorted_array = array.dup
  if sum % 2 != 0
    sorted_array.sort!
  else
    sorted_array.sort!.reverse!
  end
  sorted_array
end
