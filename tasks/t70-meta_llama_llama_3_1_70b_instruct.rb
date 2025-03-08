def strange_sort_list(lst)
  result = []
  while lst.any?
    if result.empty? || result.last == lst.min
      result << lst.min
    else
      result << lst.max
    end
    lst.delete(result.last)
  end
  result
end