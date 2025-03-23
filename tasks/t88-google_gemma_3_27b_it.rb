
def sort_array(array)
  return [] if array.empty?
  return [array[0]] if array.length == 1

  new_array = array.clone
  sum_first_last = array[0] + array[-1]

  if sum_first_last.odd?
    new_array.sort
  else
    new_array.sort.reverse
  end
end
