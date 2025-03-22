def strange_sort_list(lst)
  result = []
  remaining = lst.dup
  use_min = true
  while !remaining.empty?
    if use_min
      value = remaining.min
    else
      value = remaining.max
    end
    result << value
    remaining.delete_at(remaining.index(value))
    use_min = !use_min
  end
  result
end