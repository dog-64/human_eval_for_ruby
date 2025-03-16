def next_smallest(list)
  uniques = list.uniq
  return nil if uniques.size < 2
  uniques.sort[1]
end