def sort_array(array)
  return [] if array.empty?
  return array if array.length == 1

  sum_first_last = array[0] + array[-1]
  sorted_array = array.dup

  if sum_first_last.odd?
    sorted_array.sort!
  else
    sorted_array.sort! { |a, b| b - a }
  end

  sorted_array
end
