def next_smallest(list)
  unique_elements = list.uniq
  return nil if unique_elements.size < 2
  unique_elements.sort[1]
end