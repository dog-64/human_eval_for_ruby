def sort_array(array)
  sum = array.first + array.last
  array.sort! { |a, b| sum.odd?? a <=> b : b <=> a }
  array
end