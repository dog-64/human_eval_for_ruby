def strange_sort_list(lst)
  return [] if lst.empty?

  sorted_list = []
  remaining_list = lst.dup

  while !remaining_list.empty?
    min_val = remaining_list.min
    sorted_list << min_val
    remaining_list.delete(min_val)

    if !remaining_list.empty?
      max_val = remaining_list.max
      sorted_list << max_val
      remaining_list.delete(max_val)
    end
  end

  sorted_list
end
