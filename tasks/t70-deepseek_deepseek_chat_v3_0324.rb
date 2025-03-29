def strange_sort_list(lst)
  return [] if lst.empty?
  sorted = []
  remaining = lst.dup
  take_min = true

  until remaining.empty?
    if take_min
      value = remaining.min
    else
      value = remaining.max
    end
    sorted << value
    remaining.delete_at(remaining.index(value))
    take_min = !take_min
  end

  sorted
end