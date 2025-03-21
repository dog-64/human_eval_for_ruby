def sort_array(array)
  sum_first_last = array.first + array.last
  sorted_array = array.dup
  sorted_array.sort! { |a, b| sum_first_last.odd? ? a <=> b : b <=> a }
end