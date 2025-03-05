def strange_sort_list(lst)
  result = []
  lst = lst.dup
  while !lst.empty?
    if result.size.even?
      result << lst.delete(lst.min)
    else
      result << lst.delete(lst.max)
    end
  end
  result
end