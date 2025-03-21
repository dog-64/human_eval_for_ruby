def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = []
  while lst.size > 0
    if sorted_list.size.even?
      min_index = lst.each_index.min_by { |i| lst[i] }
      sorted_list << lst.delete_at(min_index)
    else
      max_index = lst.each_index.max_by { |i| lst[i] }
      sorted_list << lst.delete_at(max_index)
    end
  end
  sorted_list
end