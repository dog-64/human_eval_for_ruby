def strange_sort_list(lst)
  sorted = []
  temp = lst.dup
  toggle = true
  while !temp.empty?
    if toggle
      sorted << temp.delete(temp.min)
    else
      sorted << temp.delete(temp.max)
    end
    toggle = !toggle
  end
  sorted
end