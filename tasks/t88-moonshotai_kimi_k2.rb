def sort_array(array)
  return [] if array.empty?
  return array.dup if array.size == 1
  
  sorted = array.dup
  sum = array.first + array.last
  
  if sum.odd?
    sorted.sort!
  else
    sorted.sort!.reverse!
  end
  
  sorted
end