def next_smallest(list)
  return nil if list.nil? || list.length < 2

  sorted_unique = list.uniq.sort
  return nil if sorted_unique.length < 2

  sorted_unique[1]
end
