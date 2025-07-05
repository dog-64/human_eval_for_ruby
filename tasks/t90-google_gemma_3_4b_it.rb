def next_smallest(list)
  return nil if list.empty?

  unique_list = list.uniq
  return nil if unique_list.length <= 1

  unique_list.sort!
  return unique_list[1]
end
