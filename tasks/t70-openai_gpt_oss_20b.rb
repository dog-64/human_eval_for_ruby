def strange_sort_list(lst)
  sorted = lst.sort
  result = []
  while sorted.any?
    result << sorted.shift
    break unless sorted.any?
    result << sorted.pop
  end
  result
end