def sort_even_elements(list)
  list.map.with_index { |x, i| [i.even?, x] }.sort_by(&:first).map { _1[1] }
end