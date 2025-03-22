def sort_array(array)
  if array.empty?
    []
  else
    sum = array.first + array.last
    if sum.odd?
      array.sort
    else
      array.sort.reverse
    end
  end
end