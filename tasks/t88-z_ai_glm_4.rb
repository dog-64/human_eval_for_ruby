

def sort_array(array)
  return array.dup if array.empty? || array.size == 1
  
  sum = array.first + array.last
  sorted = array.dup
  
  if sum.odd?
    sorted.sort
  else
    sorted.sort.reverse
  end
end