def strange_sort_list(lst)
  sorted_list = []
  temp_list = lst.dup
  is_min_turn = true

  while !temp_list.empty?
    if is_min_turn
      min_val = temp_list.min
      sorted_list << min_val
      temp_list.delete_at(temp_list.index(min_val))
    else
      max_val = temp_list.max
      sorted_list << max_val
      temp_list.delete_at(temp_list.index(max_val))
    end
    is_min_turn = !is_min_turn
  end

  sorted_list
end
