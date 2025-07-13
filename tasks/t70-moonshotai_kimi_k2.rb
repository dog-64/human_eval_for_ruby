def strange_sort_list(lst)
  return [] if lst.empty?
  
  sorted = []
  remaining = lst.dup
  
  take_min = true
  
  until remaining.empty?
    if take_min
      min_val = remaining.min
      remaining.delete_at(remaining.index(min_val))
      sorted << min_val
    else
      max_val = remaining.max
      remaining.delete_at(remaining.index(max_val))
      sorted << max_val
    end
    
    take_min = !take_min
  end
  
  sorted
end