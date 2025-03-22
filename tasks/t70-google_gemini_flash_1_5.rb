def strange_sort_list(lst)
  return [] if lst.empty?
  result = []
  min_max = true
  while !lst.empty?
    if min_max
      min = lst.min
      result << min
      lst.delete(min)
    else
      max = lst.max
      result << max
      lst.delete(max)
    end
    min_max = !min_max
  end
  result
end
