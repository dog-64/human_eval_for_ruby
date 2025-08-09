def next_smallest(list)
  return nil if list.size < 2
  min = list.min
  second = list.select { |x| x > min }.min
  second
end