def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = []
  remaining_list = lst.dup

  min_max = true

  while !remaining_list.empty?
    if min_max
      min_val = remaining_list.min
      sorted_list << min_val
      remaining_list.delete(min_val)
    else
      max_val = remaining_list.max
      sorted_list << max_val
      remaining_list.delete(max_val)
    end
    min_max = !min_max
  end

  sorted_list
end
