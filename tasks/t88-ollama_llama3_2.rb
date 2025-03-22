def sort_array(array)
  return array if array.empty?
  first, *rest, last = array
  sum = first + last
  rest.sort!
  (first == last ? rest : [first] + rest + [last]) if sum.odd?
end