def sort_array(array)
  new_array = array.clone
  if array.empty?
    return new_array
  end

  sum = array[0] + array[-1]
  if sum % 2 == 0
    new_array.sort.reverse
  else
    new_array.sort
  end
end