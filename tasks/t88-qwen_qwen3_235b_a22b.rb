def sort_array(array)
  if array.empty?
    []
  else
    sum = array.first + array.last
    sorted = array.sort
    sum.odd? ? sorted : sorted.reverse
  end
end