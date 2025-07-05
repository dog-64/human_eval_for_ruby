def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = lst.sort
  result = []
  
  while !sorted_list.empty?
    result << sorted_list.shift
    break if sorted_list.empty?
    result << sorted_list.pop
  end
  result
end